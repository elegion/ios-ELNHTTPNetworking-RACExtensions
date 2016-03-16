//
//  MTAPIClient.m
//  network
//
//  Created by Sergey Rakov on 05.01.16.
//  Copyright © 2016 e-Legion. All rights reserved.
//

#import "AFNetworking.h"
#import "ELNHTTPCacheManager.h"
#import "ELNHTTPClientConfiguration.h"
#import "ELNHTTPClient.h"
#import "ELNHTTPRequest.h"
#import "ELNAPIResponseContext.h"
#import "ELNHTTPStubManager.h"
#import "ELNResponseMappingResult.h"
#import "ELNJSONSerialization.h"
#import "ELNAPIUtils.h"

static dispatch_queue_t ELNResponseSerializationQueue() {
    static dispatch_queue_t queue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        queue = dispatch_queue_create("ELNResponseSerializationQueue", DISPATCH_QUEUE_CONCURRENT);
    });
    return queue;
}

BOOL ELNHTTPClientIsErrorNetwork(NSError* error) {
    if ([error.domain isEqualToString:NSURLErrorDomain]) {
        switch (error.code) {
            case NSURLErrorTimedOut:
            case NSURLErrorCannotFindHost:
            case NSURLErrorCannotConnectToHost:
            case NSURLErrorNetworkConnectionLost:
            case NSURLErrorDNSLookupFailed:
            case NSURLErrorNotConnectedToInternet:
            case NSURLErrorInternationalRoamingOff:
            case NSURLErrorCallIsActive:
            case NSURLErrorDataNotAllowed:
                return YES;
        }
    }
    NSError *underlyingError = error.userInfo[NSUnderlyingErrorKey];
    if (underlyingError) {
        return ELNHTTPClientIsErrorNetwork(underlyingError);
    } else {
        return NO;
    }
}


@interface ELNHTTPClient ()

@property (copy, nonatomic) NSString *baseURL;
@property (strong, nonatomic) AFHTTPSessionManager *sessionManager;
@property (strong, nonatomic) id<ELNHTTPStubManager> stubManager;
@property (strong, nonatomic) id<ELNHTTPCacheManager> cacheManager;

@end

@implementation ELNHTTPClient

#pragma mark - Initialization

- (instancetype)init
{
    return [self initWithConfiguration:nil];
}

- (instancetype)initWithConfiguration:(id<ELNHTTPClientConfiguration>)configuration
{
    if (self = [super init])
    {
        _baseURL = configuration.baseURL;
        
        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        if ([configuration respondsToSelector:@selector(requestDefaultTimeout)]) {
            sessionConfiguration.timeoutIntervalForRequest = [configuration requestDefaultTimeout];
        }
        
        _sessionManager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:sessionConfiguration];
        if ([configuration respondsToSelector:@selector(requestSerializer)]) {
            _sessionManager.requestSerializer = [configuration requestSerializer];
        }
        if ([configuration respondsToSelector:@selector(responseSerializer)]) {
            _sessionManager.responseSerializer = [configuration responseSerializer];
        }
        if ([configuration respondsToSelector:@selector(completionQueue)]) {
            _sessionManager.completionQueue = [configuration completionQueue];
        }
        if ([configuration respondsToSelector:@selector(stubManager)]) {
            _stubManager = configuration.stubManager;
        }
        if ([configuration respondsToSelector:@selector(cacheManager)]) {
            _cacheManager = configuration.cacheManager;
        }
    }
    return self;
}

#pragma mark - Public

- (NSURLSessionTask *)sendRequest:(id<ELNHTTPRequest>)request withCompletion:(ELNHTTPRequestCompletionBlock)completion
{
    __weak typeof(self) weakSelf = self;

    // Prepare request
    
    NSString *baseURL = [request respondsToSelector:@selector(baseURL)] ? [request baseURL] : self.baseURL;
    NSString *urlString = [baseURL stringByAppendingPathComponent:[request path]];

    NSMutableDictionary *parameters = [NSMutableDictionary new];
    if ([self respondsToSelector:@selector(clientParametersForRequest:)]) {
        [parameters addEntriesFromDictionary:[self clientParametersForRequest:request] ?: @{}];
    }
    if ([request respondsToSelector:@selector(parameters)]) {
        [parameters addEntriesFromDictionary:[request parameters] ?: @{}];
    }
    // Empty param dictionary creates "?" in URL
    if (parameters.count == 0) {
        parameters = nil;
    }
    
    NSError *requestSerizlizationError;

    NSMutableURLRequest *urlRequest = [self.sessionManager.requestSerializer requestWithMethod:[request HTTPMethod]
                                                                                     URLString:urlString
                                                                                    parameters:parameters
                                                                                         error:&requestSerizlizationError];
    NSAssert(requestSerizlizationError == nil, @"Request serialization error");
    if ([request respondsToSelector:@selector(timeout)]) {
        urlRequest.timeoutInterval = [request timeout];
    }
    
    // Stub request if needed

    void (^stubCompletion)();
    if ([self.stubManager hasStubForRequest:request]) {
        id stub = [self.stubManager stubRequest:request URLRequest:urlRequest];
        stubCompletion = ^() {
            [weakSelf.stubManager removeStub:stub];
        };
    }
    
    // Execute task
    
    NSURLSessionDataTask *task = [self.sessionManager dataTaskWithRequest:urlRequest completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (completion) {
            dispatch_async(ELNResponseSerializationQueue(), ^{

                ELNResponseMappingResult *responseMappingResult = [self mapRequest:request response:response responseObject:responseObject error:error];
                ELNAPIResponseContext *responseContext = [[ELNAPIResponseContext alloc] initWithRequest:urlRequest response:response];

                if (self.cacheManager != nil && [request respondsToSelector:@selector(isCached)] && [request isCached]) {
                    if (!error && responseMappingResult.responseObject) {
                        [self.cacheManager cacheResponseObject:responseMappingResult.responseObject forRequest:request];
                    } else if (error && [self shouldUseCachedResponseForRequest:request error:error]) {
                        responseMappingResult.responseObject = [self.cacheManager responseObjectForRequest:request];
                    }
                }

                dispatch_async(weakSelf.sessionManager.completionQueue ?: dispatch_get_main_queue(), ^{
                    completion(responseMappingResult.responseObject, responseMappingResult.error, responseContext);
                });
            });
        }
        if (stubCompletion) {
            stubCompletion();
        }
    }];

    [task resume];
    return task;
}

#pragma mark - ELNHTTPClient

- (ELNResponseMappingResult *)mapRequest:(id<ELNHTTPRequest>)request response:(NSURLResponse *)response responseObject:(id)responseObject error:(NSError *)error
{
    id resultObject;
    NSError *resultError = error;
    
    Class responseClass;
    if ([request respondsToSelector:@selector(responseClass)]) {
        responseClass = [request responseClass];
    }
    NSError *serializationError;
    resultObject = ELNObjectFromJSON(responseObject, responseClass, &serializationError);
    if (serializationError) {
        resultError = serializationError;
    }
    
    return [[ELNResponseMappingResult alloc] initWithResponseObject:resultObject error:resultError];
}

- (BOOL)shouldUseCachedResponseForRequest:(id<ELNHTTPRequest>)request error:(NSError *)error
{
    return ELNHTTPClientIsErrorNetwork(error);
}

@end

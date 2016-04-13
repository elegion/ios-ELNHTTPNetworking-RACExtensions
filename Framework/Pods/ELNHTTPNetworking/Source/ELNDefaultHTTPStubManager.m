//
//  ELNDefaultStubManager.m
//  network
//
//  Created by Sergey Rakov on 12/01/16.
//  Copyright © 2016 e-Legion. All rights reserved.
//

#import "Mantle.h"
#import "OHHTTPStubs.h"
#import "ELNDefaultHTTPStubManager.h"
#import "ELNHTTPRequest.h"
#import "ELNHTTPRequestStub.h"
#import "ELNAPIUtils.h"

@interface ELNDefaultHTTPStubManager ()

@end

@implementation ELNDefaultHTTPStubManager

#pragma mark - Public

- (BOOL)hasStubForRequest:(id<ELNHTTPRequest>)request
{
    return [[self stubClassForRequest:request] hasObjectForRequest:request context:[self contextForRequest:request]];
}

- (id)stubRequest:(id<ELNHTTPRequest>)request URLRequest:(NSURLRequest *)URLRequest
{
    return [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *testURLRequest) {
        BOOL isEqualURL = [URLRequest.URL.absoluteString isEqualToString:testURLRequest.URL.absoluteString];
        BOOL isEqualMethod = [URLRequest.HTTPMethod isEqualToString:testURLRequest.HTTPMethod];
        return isEqualURL && isEqualMethod;
    } withStubResponse:^OHHTTPStubsResponse * _Nonnull(NSURLRequest * _Nonnull stubbedRequest) {
        id<ELNHTTPRequestStub> stub = [self stubForRequest:request];
        id context = [self contextForRequest:request];
        id object = [stub objectForRequest:request context:context];
        OHHTTPStubsResponse *stubResponse = nil;
        if ([object isKindOfClass:[NSString class]]) {
            stubResponse = [self stubResponseWithString:object];
        } else if ([object conformsToProtocol:@protocol(MTLJSONSerializing)]) {
            stubResponse = [self stubResponseWithObject:object];
        } else if ([object isKindOfClass:[NSError class]]) {
            stubResponse = [self stubResponseWithError:object];
        } else if ([object isKindOfClass:[OHHTTPStubsResponse class]]) {
            stubResponse = object;
        } else if ([object isKindOfClass:[NSArray class]]) {
            stubResponse = [self stubResponseWithArray:object];
        }
        stubResponse.responseTime = [stub responseTimeForRequest:request context:context];
        return stubResponse;
    }];
}

- (void)removeStub:(id)stub
{
    [OHHTTPStubs removeStub:stub];
}

- (id)contextForRequest:(id<ELNHTTPRequest>)request
{
    return nil;
}

- (void)removeAllStubs
{
    [OHHTTPStubs removeAllStubs];
}

- (NSDictionary *)stubHeaders
{
    return @{@"Content-Type" : @"application/json"};
}

#pragma mark - Logics

- (Class)stubClassForRequest:(id<ELNHTTPRequest>)request
{
    Class stubClass = NSClassFromString([NSStringFromClass([request class]) stringByAppendingString:@"Stub"]);
    NSAssert(!stubClass || [stubClass conformsToProtocol:@protocol(ELNHTTPRequestStub)], @"Stub class must conform ELNHTTPRequestStub.");
    return stubClass;
}

- (id<ELNHTTPRequestStub>)stubForRequest:(id<ELNHTTPRequest>)request
{
    return [[self stubClassForRequest:request] new];
}

- (OHHTTPStubsResponse *)stubResponseWithString:(NSString *)string
{
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    OHHTTPStubsResponse *response = [OHHTTPStubsResponse responseWithData:data statusCode:200 headers:[self stubHeaders]];
    return response;
}

- (OHHTTPStubsResponse *)stubResponseWithObject:(id<MTLJSONSerializing>)responseObject
{
    NSError *error;
    NSData *data = ELNDataWithModel(responseObject, &error);
    NSAssert(error == nil, @"%@", error);
    OHHTTPStubsResponse *response = [OHHTTPStubsResponse responseWithData:data statusCode:200 headers:[self stubHeaders]];
    return response;
}

- (OHHTTPStubsResponse *)stubResponseWithError:(NSError *)error
{
    OHHTTPStubsResponse *response = [OHHTTPStubsResponse responseWithError:error];
    return response;
}

- (OHHTTPStubsResponse *)stubResponseWithArray:(NSArray<MTLModel *> *)array
{
    NSError *error;
    NSArray<NSDictionary *> *JSONArray = [MTLJSONAdapter JSONArrayFromModels:array error:&error];
    NSAssert(error == nil, @"%@", error);
    NSData *data = [NSJSONSerialization dataWithJSONObject:JSONArray options:NSJSONWritingPrettyPrinted error:&error];
    NSAssert(error == nil, @"%@", error);
    OHHTTPStubsResponse *response = [OHHTTPStubsResponse responseWithData:data statusCode:200 headers:[self stubHeaders]];
    return response;
}

@end

//
//  ELNDefaultHTTPCacheManager.m
//  network
//
//  Created by Sergey Rakov on 16.03.16.
//  Copyright © 2016 e-Legion. All rights reserved.
//

#import "PinCache.h"
#import "ELNDefaultHTTPCacheManager.h"
#import "ELNHTTPRequest.h"


static NSString *ELNDefaultHTTPCacheManagerKeyFromRequest(id<ELNHTTPRequest>request)
{
    NSCParameterAssert(request);
    
    NSMutableString *key = [NSMutableString stringWithFormat:@"%@%@", [request HTTPMethod], [request path]];
    if ([request respondsToSelector:@selector(parameters)]) {
        [key appendString:[request parameters].description];
    }
    if ([request respondsToSelector:@selector(baseURL)]) {
        [key appendString:[request baseURL]];
    }
    return [key copy];
}


@interface ELNDefaultHTTPCacheManager ()

@property (strong, nonatomic) PINCache *cache;

@end

@implementation ELNDefaultHTTPCacheManager

#pragma mark - Initialization

- (instancetype)init
{
    if (self = [super init]) {
        self.cache = [[PINCache alloc] initWithName:NSStringFromClass([self class])];
    }
    return self;
}

#pragma mark - ELNHTTPCacheManager

- (id)responseObjectForRequest:(id<ELNHTTPRequest>)request
{
    return [self.cache objectForKey:ELNDefaultHTTPCacheManagerKeyFromRequest(request)];
}

- (void)cacheResponseObject:(id<NSCoding>)responseObject forRequest:(id<ELNHTTPRequest>)request
{
    NSAssert([(id)responseObject conformsToProtocol:@protocol(NSCoding)], @"Cached object must satisfy NSCoding.");
    [self.cache setObject:responseObject forKey:ELNDefaultHTTPCacheManagerKeyFromRequest(request) block:nil];
}

- (void)removeResponseForRequest:(id<ELNHTTPRequest>)request
{
    [self.cache removeObjectForKey:ELNDefaultHTTPCacheManagerKeyFromRequest(request) block:nil];
}

- (void)removeAllResponses
{
    [self.cache removeAllObjects:nil];
}

@end

//
//  ELNDemoRequest.m
//  ELNHTTPNetworking-RACExtensions
//
//  Created by Geor Kasapidi on 17.02.16.
//  Copyright © 2016 Geor Kasapidi. All rights reserved.
//

#import "ELNDemoRequest.h"
#import "ELNDemoModel.h"

@implementation ELNDemoRequest

- (NSString *)HTTPMethod
{
    return @"GET";
}

- (NSString *)path
{
    return @"posts";
}

- (NSDictionary *)parameters
{
    return @{@"userId": @(1)};
}

- (NSTimeInterval)timeout
{
    return 10;
}

- (NSString *)baseURL
{
    return @"http://jsonplaceholder.typicode.com";
}

- (Class<MTLJSONSerializing>)responseClass
{
    return [ELNDemoModel class];
}

@end

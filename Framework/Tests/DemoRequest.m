//
//  DemoRequest.m
//  ELNHTTPNetworking-RACExtensions
//
//  Created by Dmitry Nesterenko on 12.04.16.
//  Copyright © 2016 e-legion. All rights reserved.
//

#import "DemoRequest.h"
#import "DemoModel.h"

@implementation DemoRequest

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
    return [DemoModel class];
}

@end

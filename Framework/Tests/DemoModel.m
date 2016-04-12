//
//  DemoModel.m
//  ELNHTTPNetworking-RACExtensions
//
//  Created by Dmitry Nesterenko on 12.04.16.
//  Copyright © 2016 e-legion. All rights reserved.
//

#import "DemoModel.h"

@implementation DemoModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{NSStringFromSelector(@selector(postId)): @"id",
             NSStringFromSelector(@selector(userId)): @"userId",
             NSStringFromSelector(@selector(title)): @"title",
             NSStringFromSelector(@selector(body)): @"body"};
}

@end

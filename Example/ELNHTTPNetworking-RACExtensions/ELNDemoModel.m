//
//  ELNDemoModel.m
//  ELNHTTPNetworking-RACExtensions
//
//  Created by Geor Kasapidi on 17.02.16.
//  Copyright © 2016 Geor Kasapidi. All rights reserved.
//

#import "ELNDemoModel.h"

@implementation ELNDemoModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{NSStringFromSelector(@selector(postId)): @"id",
             NSStringFromSelector(@selector(userId)): @"userId",
             NSStringFromSelector(@selector(title)): @"title",
             NSStringFromSelector(@selector(body)): @"body"};
}

@end

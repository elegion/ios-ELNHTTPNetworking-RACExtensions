//
//  ELNResponseMappingResult.m
//  network
//
//  Created by Sergey Rakov on 12/01/16.
//  Copyright © 2016 e-Legion. All rights reserved.
//

#import "ELNResponseMappingResult.h"

@implementation ELNResponseMappingResult

- (instancetype)initWithResponseObject:(id)responseObject error:(NSError *)error
{
    if (self = [super init]) {
        _responseObject = responseObject;
        _error = error;
    }
    return self;
}

@end

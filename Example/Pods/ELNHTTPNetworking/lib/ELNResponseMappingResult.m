//
//  ELNResponseMappingResult.m
//  network
//
//  Created by Sergey Rakov on 12/01/16.
//  Copyright © 2016 e-Legion. All rights reserved.
//

#import "ELNResponseMappingResult.h"

@interface ELNResponseMappingResult ()

@property (strong, nonatomic) id responseObject;
@property (strong, nonatomic) NSError *error;

@end

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

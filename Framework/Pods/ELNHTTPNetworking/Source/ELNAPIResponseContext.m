//
//  ELNAPIResponseContext.m
//  e-legion
//
//  Created by Dmitry Nesterenko on 13.10.15.
//  Copyright © 2015 e-legion. All rights reserved.
//

#import "ELNAPIResponseContext.h"

@implementation ELNAPIResponseContext

#pragma mark - Initialization

- (instancetype)initWithRequest:(NSURLRequest *)request response:(NSURLResponse *)response
{
    if (self = [super init]) {
        _request = request;
        _response = response;
    }
    return self;
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone {
    typeof(self) copy = [self.class new];
    copy.request = self.request;
    copy.response = self.response;
    
    return copy;
}

#pragma mark - Describing Objects

- (NSString *)description {
    NSDictionary *properties = @{NSStringFromSelector(@selector(request)): self.request ?: @"<nil>",
                                 NSStringFromSelector(@selector(response)): self.response ?: @"<nil>"};
    return [NSString stringWithFormat:@"<%@: %p %@>", NSStringFromClass(self.class), self, properties];
}

@end

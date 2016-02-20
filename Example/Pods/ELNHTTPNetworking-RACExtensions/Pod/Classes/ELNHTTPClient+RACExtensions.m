//
//  ELNHTTPClient+RACExtensions.m
//  Pods
//
//  Created by Geor Kasapidi on 17.02.16.
//
//

#import "ELNHTTPClient+RACExtensions.h"

@implementation ELNHTTPClient (RACExtensions)

- (RACSignal *)rac_sendRequest:(id<ELNHTTPRequest>)request
{
    @weakify(self);
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        
        NSURLSessionTask *task = [self sendRequest:request withCompletion:^(id responseObject, NSError *error, ELNAPIResponseContext *context) {
            [subscriber sendNext:responseObject];
            
            if (error) {
                [subscriber sendError:error];
            } else {
                [subscriber sendCompleted];
            }
        }];
        
        return [RACDisposable disposableWithBlock:^{
            [task cancel];
        }];
    }];
}

@end

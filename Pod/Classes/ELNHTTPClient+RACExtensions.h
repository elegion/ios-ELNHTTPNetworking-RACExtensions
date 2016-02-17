//
//  ELNHTTPClient+RACExtensions.h
//  Pods
//
//  Created by Geor Kasapidi on 17.02.16.
//
//

#import <ELNHTTPNetworking/ELNHTTPNetworking.h>
#import <ReactiveCocoa.h>

@interface ELNHTTPClient (RACExtensions)

- (RACSignal *)rac_sendRequest:(id<ELNHTTPRequest>)request;

@end

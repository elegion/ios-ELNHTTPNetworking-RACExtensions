//
//  ELNDemoModel.h
//  ELNHTTPNetworking-RACExtensions
//
//  Created by Geor Kasapidi on 17.02.16.
//  Copyright © 2016 Geor Kasapidi. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface ELNDemoModel : MTLModel <MTLJSONSerializing>

@property (assign, nonatomic) NSInteger postId;
@property (assign, nonatomic) NSInteger userId;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *body;

@end

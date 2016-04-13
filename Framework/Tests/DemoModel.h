//
//  DemoModel.h
//  ELNHTTPNetworking-RACExtensions
//
//  Created by Dmitry Nesterenko on 12.04.16.
//  Copyright © 2016 e-legion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>

@interface DemoModel : MTLModel <MTLJSONSerializing>

@property (assign, nonatomic) NSInteger postId;
@property (assign, nonatomic) NSInteger userId;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *body;

@end

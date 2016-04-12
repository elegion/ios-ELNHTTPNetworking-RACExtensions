//
//  ELNAPIStub.h
//  Megafon
//
//  Created by Sergey Rakov on 18.11.15.
//  Copyright © 2015 e-legion. All rights reserved.
//

@import Foundation;

@protocol ELNHTTPRequest;

/**
 Реализация заглушек.
 */
@protocol ELNHTTPRequestStub <NSObject>

/// Есть ли заглушка для определённого запроса
+ (BOOL)hasObjectForRequest:(id<ELNHTTPRequest>)request context:(id)context;
/** 
 Объект заглушки для определённого запроса. 
 Типы, поддерживаемые реализацией по умолчанию: NSString, id<MTLJSONSerializing>, NSError, OHHTTPStubsResponse, NSArray<MTLModel *>
 */
- (id)objectForRequest:(id<ELNHTTPRequest>)request context:(id)context;
/// Время ответа для заглушки.
- (NSTimeInterval)responseTimeForRequest:(id<ELNHTTPRequest>)request context:(id)context;

@end

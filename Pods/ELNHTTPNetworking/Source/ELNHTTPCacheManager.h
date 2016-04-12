//
//  ELNHTTPCache.h
//  network
//
//  Created by Sergey Rakov on 16.03.16.
//  Copyright © 2016 e-Legion. All rights reserved.
//

@import Foundation;

@protocol ELNHTTPRequest;

/**
 Протокол для менеджера оффлайн-кеша.
 */
@protocol ELNHTTPCacheManager

/// Возвращает объект для запроса.
- (id)responseObjectForRequest:(id<ELNHTTPRequest>)request;
/** 
 Сохранить объект для запроса.
 @warning объект должен удовлетворять NSCoding.
 */
- (void)cacheResponseObject:(id<NSCoding>)responseObject forRequest:(id<ELNHTTPRequest>)request;
/// Удалить объект для запроса.
- (void)removeResponseForRequest:(id<ELNHTTPRequest>)request;
/// Удалить все объекты.
- (void)removeAllResponses;

@end

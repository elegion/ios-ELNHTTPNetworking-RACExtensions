//
//  ELNHTTPRequest.h
//  network
//
//  Created by Sergey Rakov on 11/01/16.
//  Copyright © 2016 e-Legion. All rights reserved.
//

@import Foundation;

@protocol MTLJSONSerializing;

/**
 Протокол для классов запроса.
 */
@protocol ELNHTTPRequest <NSObject>

@required
/// Метод HTTP.
- (NSString *)HTTPMethod;
/// Относительный путь.
- (NSString *)path;

@optional
/// Параметры запроса.
- (NSDictionary *)parameters;
/** 
 Величина таймаута для конкретного запроса. 
 Приоритетнее, чем интервал, задаваемый по умолчанию в ELNHTTPClient -requestDefaultTimeout.
 */
- (NSTimeInterval)timeout;
/// Класс ответа. По умолчанию для массивов используется класс их элементов.
- (Class<MTLJSONSerializing>)responseClass;
/// Базовый URL для конкретного запроса.
- (NSString *)baseURL;
/// Кешируются ли ответы для данного запроса.
- (BOOL)isCached;

@end

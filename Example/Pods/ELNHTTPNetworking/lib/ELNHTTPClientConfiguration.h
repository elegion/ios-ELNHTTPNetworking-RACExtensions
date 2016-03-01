//
//  ELNAPIClientConfiguration.h
//  network
//
//  Created by Sergey Rakov on 11/01/16.
//  Copyright © 2016 e-Legion. All rights reserved.
//

@import Foundation;

@protocol ELNHTTPStubManager;
@class AFHTTPRequestSerializer;
@class AFHTTPResponseSerializer;

/**
 Конфигурация для HTTP клиента. При необходимости передать в клиент
 больше параметров их следует добавлять в класс конфигурации.
 */
@protocol ELNHTTPClientConfiguration <NSObject>

@required

/// Базовый адрес запросов.
@property (readonly, nonatomic) NSString *baseURL;

@optional

/// Сериализатор запросов.
- (AFHTTPRequestSerializer *)requestSerializer;
/// Сериализатор ответов.
- (AFHTTPResponseSerializer *)responseSerializer;
/**
 Значение величины таймаута для всех запросов клиента.
 Может быть изменено для отдельного запроса (см. ELNHTTPRequest).
 */
- (NSTimeInterval)requestDefaultTimeout;
/// Очередь, на которой выполняются completion блоки.
- (dispatch_queue_t)completionQueue;
/// Менеджер для моков.
@property (readonly, nonatomic) id<ELNHTTPStubManager> stubManager;

@end

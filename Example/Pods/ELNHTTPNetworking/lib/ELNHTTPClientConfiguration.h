//
//  ELNAPIClientConfiguration.h
//  network
//
//  Created by Sergey Rakov on 11/01/16.
//  Copyright © 2016 e-Legion. All rights reserved.
//

@import Foundation;

@protocol ELNHTTPStubManager;

/**
 Конфигурация для HTTP клиента. При необходимости передать в клиент
 больше параметров их следует добавлять в класс конфигурации.
 */
@protocol ELNHTTPClientConfiguration <NSObject>

@required
/// Базовый адрес запросов.
@property (readonly, nonatomic) NSString *baseURL;

@optional
/// Менеджер для моков.
@property (readonly, nonatomic) id<ELNHTTPStubManager> stubManager;

@end

//
//  MTAPIClient.h
//  network
//
//  Created by Sergey Rakov on 05.01.16.
//  Copyright © 2016 e-Legion. All rights reserved.
//

@import Foundation;


@class AFHTTPRequestSerializer;
@class AFHTTPResponseSerializer;
@class AFHTTPSessionManager;
@class ELNAPIResponseContext;
@class ELNResponseMappingResult;
@protocol ELNHTTPClientConfiguration;
@protocol ELNHTTPRequest;


/// Тип блоков, выполняемых при завершении NSURLSessionDataTask.
typedef void(^ELNDataTaskCompletionBlock)(NSURLResponse *response, id responseObject, NSError *error);
/// Тип блоков, выполняемых при завершении запроса клиента.
typedef void (^ELNHTTPRequestCompletionBlock)(id responseObject, NSError *error, ELNAPIResponseContext *context);


/**
 Протокол для написания сетевых клиентов. Позволяет кастомизировать поведение AFURLSessionManager.
 Для создания клиента необходимо наследоваться от ELNHTTPClient и прописать методы ELNHTTPClient.
 */
@protocol ELNHTTPClient <NSObject>

@optional

/**
 Добавление дополнительных параметров в запрос. Предназначено для добавления 
 общих параметров для всех запросов или определённых групп (например, POST).
 */
- (NSDictionary *)clientParametersForRequest:(id<ELNHTTPRequest>)request;
/**
 Метод для дополнительной сериализации ответов.
 @return Возвращает ELNResponseMappingResult, содержащий итоговые значения responseObject и error, 
 которые передаются в ELNHTTPRequestCompletionBlock.
 @warning Выполняется на отдельной очереди.
 @discussion По умолчанию сериализует JSON объект в модель класса, указанного в request
 и возвращает ошибку сериализации или ошибку сети.
 */
- (ELNResponseMappingResult *)mapRequest:(id<ELNHTTPRequest>)request response:(NSURLResponse *)response responseObject:(id)responseObject error:(NSError *)error;

@end


/**
 Ядро сетевого клиента. Для создания клиента необходимо наследоваться от ELNHTTPClient и прописать методы ELNHTTPClient.
 Для передачи дополнительных данных в клиент их нужно добавлять в конфигурацию.
 */
@interface ELNHTTPClient : NSObject <ELNHTTPClient>

- (instancetype)initWithConfiguration:(id<ELNHTTPClientConfiguration>)configuration NS_DESIGNATED_INITIALIZER;

/// Менеджер сессии, на основе которого работает клиент.
@property (readonly, nonatomic) AFHTTPSessionManager *sessionManager;

/// Отправка запроса.
- (NSURLSessionTask *)sendRequest:(id<ELNHTTPRequest>)request withCompletion:(ELNHTTPRequestCompletionBlock)completion;

@end

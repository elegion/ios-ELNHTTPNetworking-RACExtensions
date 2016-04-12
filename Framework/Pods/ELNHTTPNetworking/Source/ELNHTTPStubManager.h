//
//  MFNAPIStubManager.h
//  Megafon
//
//  Created by Sergey Rakov on 24/11/15.
//  Copyright © 2015 e-legion. All rights reserved.
//

@import Foundation;


@protocol ELNHTTPRequest;
@protocol ELNHTTPRequestStub;


/**
 Протокол для реализации заглушек. Ммеет реализацию по умолчанию - ELNHTTPStubManager.
 */
@protocol ELNHTTPStubManager <NSObject>

@required
/// Есть ли объект заглушки для запроса.
- (BOOL)hasStubForRequest:(id<ELNHTTPRequest>)request;
/** 
 Объект заглушки для запроса.
 @return Возвращает объект, которы должен принимать removeStub:
 */
- (id)stubRequest:(id<ELNHTTPRequest>)request URLRequest:(NSURLRequest *)URLRequest;
/// Удаление заглушки.
- (void)removeStub:(id)stub;

@optional
/// Контекст для заглушки. Через него определяется состояние приложения.
- (id)contextForRequest:(id<ELNHTTPRequest>)request;
/// Удаляет все заглушки.
- (void)removeAllStubs;
/// Дополнительные заголовки, которые должен возвращать ответ. Например, Content-Type.
- (NSDictionary *)stubHeaders;

@end

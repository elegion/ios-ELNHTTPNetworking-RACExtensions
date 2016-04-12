//
//  ELNAPIResponseContext.h
//  e-legion
//
//  Created by Dmitry Nesterenko on 13.10.15.
//  Copyright © 2015 e-legion. All rights reserved.
//

@import Foundation;

/// Контекст ответа сервера.
@interface ELNAPIResponseContext : NSObject <NSCopying>

- (instancetype)initWithRequest:(NSURLRequest *)request response:(NSURLResponse *)response;

/// Запрос.
@property (nonatomic, copy) NSURLRequest *request;
/// Ответ.
@property (nonatomic, copy) NSURLResponse *response;

@end

//
//  ELNResponseMappingResult.h
//  network
//
//  Created by Sergey Rakov on 12/01/16.
//  Copyright © 2016 e-Legion. All rights reserved.
//

@import Foundation;

/// Результат обработки результата запроса
@interface ELNResponseMappingResult : NSObject

- (instancetype)initWithResponseObject:(id)responseObject error:(NSError *)error;

/// Преобразованный объект ответа
@property (readonly, nonatomic) id responseObject;
/// Преобразованная ошибка
@property (readonly, nonatomic) NSError *error;

@end

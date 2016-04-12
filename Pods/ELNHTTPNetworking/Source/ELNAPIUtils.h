//
//  ELNNetworkUtils.h
//  network
//
//  Created by Sergey Rakov on 11/01/16.
//  Copyright © 2016 e-Legion. All rights reserved.
//

@import Foundation;

@protocol MTLJSONSerializing;

/// Создание ошибки домена ELNAPIResponseSerializerErrorDomain с кодом, описанием и внутренней ошибкой.
NSError * _Nonnull ELNAPIErrorWithUnderlyingError(NSInteger code, NSString * _Nullable localizedDescription, NSError * _Nullable underlyingError);
/// Создание ошибки с доменом, кодом, описанием и внутренней ошибкой.
NSError * _Nonnull ELNErrorWithUnderlyingError(NSString * _Nonnull domain, NSInteger code, NSString * _Nullable localizedDescription, NSError * _Nullable underlyingError);

/// Десериализация модели в данные.
NSData * _Nullable ELNDataWithModel(id<MTLJSONSerializing> _Nonnull model, NSError * _Nullable * _Nullable error);

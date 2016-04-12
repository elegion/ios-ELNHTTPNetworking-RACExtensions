//
//  ELNNetworkConstants.h
//  network
//
//  Created by Sergey Rakov on 11/01/16.
//  Copyright © 2016 e-Legion. All rights reserved.
//

@import Foundation;

/// Домен ошибок сериализации.
extern NSString * const ELNAPIResponseSerializerErrorDomain;

typedef NS_ENUM(NSInteger, ELNAPIErrorCode)
{
    /// Не удалось сериализовать объект JSON в модель.
    ELNAPIErrorCodeJSONToModelSerialization
};

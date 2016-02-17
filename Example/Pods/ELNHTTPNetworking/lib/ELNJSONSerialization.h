//
//  MTJSONSerialization.h
//  network
//
//  Created by Sergey Rakov on 11/01/16.
//  Copyright © 2016 e-Legion. All rights reserved.
//

@import Foundation;

@protocol MTLJSONSerializing;

/// Сериализация объекта JSON в модель с помощью Mantle.
id ELNObjectFromJSON(id JSON, Class<MTLJSONSerializing> responseClass, NSError **error);

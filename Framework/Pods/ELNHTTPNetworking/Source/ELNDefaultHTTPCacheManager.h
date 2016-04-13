//
//  ELNDefaultHTTPCacheManager.h
//  network
//
//  Created by Sergey Rakov on 16.03.16.
//  Copyright © 2016 e-Legion. All rights reserved.
//

#import "ELNHTTPCacheManager.h"

/**
 Реализация оффлайн-кеша запросов по умолчанию. Использует PINCache и формирует ключи 
 по основным полям запроса.
 */
@interface ELNDefaultHTTPCacheManager : NSObject <ELNHTTPCacheManager>

@end

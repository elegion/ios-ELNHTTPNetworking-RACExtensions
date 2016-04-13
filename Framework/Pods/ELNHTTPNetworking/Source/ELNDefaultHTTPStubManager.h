//
//  ELNDefaultStubManager.h
//  network
//
//  Created by Sergey Rakov on 12/01/16.
//  Copyright © 2016 e-Legion. All rights reserved.
//

#import "ELNHTTPStubManager.h"

/**
 Реализация ELNHTTPStubManager по умолчанию.
 Класс заглушки определяется по имени запроса с добавлением Stub (ELNAnyRequest -> ELNAnyRequestStub).
 Для заглушек используется OHHTTPStubs.
 Типы объектов, поддерживаемые реализацией по умолчанию: NSString, id<MTLJSONSerializing>, NSError, OHHTTPStubsResponse, NSArray<MTLModel *> *
 */
@interface ELNDefaultHTTPStubManager : NSObject <ELNHTTPStubManager>

@end

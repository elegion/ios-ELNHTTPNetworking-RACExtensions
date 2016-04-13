//
//  ELNNetworkUtils.m
//  network
//
//  Created by Sergey Rakov on 11/01/16.
//  Copyright © 2016 e-Legion. All rights reserved.
//

#import "Mantle.h"
#import "ELNAPIConstants.h"
#import "ELNAPIUtils.h"

NSError * _Nonnull ELNAPIErrorWithUnderlyingError(NSInteger code, NSString * _Nullable localizedDescription, NSError * _Nullable underlyingError)
{
    return ELNErrorWithUnderlyingError(ELNAPIResponseSerializerErrorDomain, code, localizedDescription, underlyingError);
}

NSError * _Nonnull ELNErrorWithUnderlyingError(NSString * _Nonnull domain, NSInteger code, NSString * _Nullable localizedDescription, NSError * _Nullable underlyingError)
{
    NSMutableDictionary *userInfo = [NSMutableDictionary new];
    
    if (localizedDescription) {
        userInfo[NSLocalizedDescriptionKey] = localizedDescription;
    }
    
    if (underlyingError) {
        userInfo[NSUnderlyingErrorKey] = underlyingError;
    }
    
    return [NSError errorWithDomain:ELNAPIResponseSerializerErrorDomain code:code userInfo:userInfo];
}

NSData * _Nullable ELNDataWithModel(id<MTLJSONSerializing> _Nonnull model, NSError * _Nullable * _Nullable error)
{
    NSError *mantleError;
    NSDictionary *object = [MTLJSONAdapter JSONDictionaryFromModel:model error:&mantleError];
    if (mantleError) {
        if (error != NULL) {
            *error = mantleError;
        }
        return nil;
    }
    
    NSError *JSONError;
    NSData *data = [NSJSONSerialization dataWithJSONObject:object options:(NSJSONWritingOptions)0 error:&JSONError];
    if (JSONError) {
        if (error != NULL) {
            *error = JSONError;
        }
        return nil;
    }
    
    return data;
}

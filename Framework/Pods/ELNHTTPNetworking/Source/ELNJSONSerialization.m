//
//  MTJSONSerialization.m
//  network
//
//  Created by Sergey Rakov on 11/01/16.
//  Copyright © 2016 e-Legion. All rights reserved.
//

#import "Mantle.h"
#import "ELNAPIConstants.h"
#import "ELNAPIUtils.h"
#import "ELNJSONSerialization.h"

id ELNObjectFromJSON(id JSON, Class<MTLJSONSerializing> responseClass, NSError **error)
{
    if (!responseClass) return JSON;
    
    id result;
    NSError *modelError;

    if ([JSON isKindOfClass:[NSArray class]]) {
        result = [MTLJSONAdapter modelsOfClass:responseClass fromJSONArray:JSON error:&modelError];
        if (![result isKindOfClass:[NSArray class]]) {
            if (error != NULL) {
                *error = ELNAPIErrorWithUnderlyingError(ELNAPIErrorCodeJSONToModelSerialization, @"Could not serialize JSON object to model", modelError);
            }
            return nil;
        }
        return result;
    } else if ([JSON isKindOfClass:[NSDictionary class]]) {
        result = [MTLJSONAdapter modelOfClass:responseClass fromJSONDictionary:JSON error:&modelError];
        if (![result isKindOfClass:responseClass]) {
            if (error != NULL) {
                *error = ELNAPIErrorWithUnderlyingError(ELNAPIErrorCodeJSONToModelSerialization, @"Could not serialize JSON object to model", modelError);
            }
            return nil;
        }
        return result;
    }
    return JSON;
}

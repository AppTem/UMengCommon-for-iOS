//
//  UMengAnalyticsANE.h
//  UMengAnalyticsANE
//
//  Created by Emck on 8/1/13.
//  Copyright (c) 2013 Apptem. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FlashRuntimeExtensions.h"

#define ANE_FUNCTION(f) FREObject (f)(FREContext ctx, void *data, uint32_t argc, FREObject argv[])
#define MAP_FUNCTION(f, data) { (const uint8_t*)(#f), (data), &(f) }

@interface UMengAnalyticsANE : NSObject

@property (nonatomic, assign) FREContext context;

@end

/////// ObjectC本地方法列表
ANE_FUNCTION(UMengAnalyticsStart);   // 启动友盟分析

void UMengAnalyticsANEExtInitializer(void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet);

void UMengAnalyticsANEExtFinalizer(void* extData);

void UMengAnalyticsContextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToTest, const FRENamedFunction** functionsToSet);

void UMengAnalyticsContextFinalizer(FREContext ctx);
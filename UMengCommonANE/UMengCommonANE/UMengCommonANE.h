//
//  UMengCommonANE.h
//  UMengCommonANE
//
//  Created by Emck on 9/25/13.
//  Copyright (c) 2013 Apptem. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FlashRuntimeExtensions.h"

#import <UMengCommon/UMengCommon.h>

#define ANE_FUNCTION(f) FREObject (f)(FREContext ctx, void *data, uint32_t argc, FREObject argv[])
#define MAP_FUNCTION(f, data) { (const uint8_t*)(#f), (data), &(f) }

@interface UMengCommonANE : NSObject <UMSocialShareResult>

@property (nonatomic, assign) FREContext context;

@end

/////// ObjectC本地方法列表
ANE_FUNCTION(UMengCommonInit);                       // 初始化
ANE_FUNCTION(UMengCommonShareText);                  // 分享文字(不带图片)
ANE_FUNCTION(UMengCommonShareTextWithImageFile);     // 分享文字+本地图片
ANE_FUNCTION(UMengCommonShareTextWithUrl);           // 分享文字+网络资源


void UMengCommonANEExtInitializer(void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet);

void UMengCommonANEExtFinalizer(void* extData);

void UMengCommonANEContextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToTest, const FRENamedFunction** functionsToSet);

void UMengCommonANEContextFinalizer(FREContext ctx);
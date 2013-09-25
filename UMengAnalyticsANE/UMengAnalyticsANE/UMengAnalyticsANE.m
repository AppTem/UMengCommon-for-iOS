//
//  UMengAnalyticsANE.m
//  UMengAnalyticsANE
//
//  Created by Emck on 8/1/13.
//  Copyright (c) 2013 Apptem. All rights reserved.
//

#import "UMengAnalyticsANE.h"

#import <UMengAnalytics/MobClick.h>

static UMengAnalyticsANE* UMengAnalyticsANE_handler;          // UMengAnalyticsANE主句柄

@interface UMengAnalyticsANE ()

@end

@implementation UMengAnalyticsANE
{
}

@synthesize context;

- (id)initWithContext:(FREContext)extensionContext
{
    self = [super init];
    if (self) {
        self.context = extensionContext;
    }
    return self;
}

// 将FREObject转成NSString
- (NSString*)getStringFromFREObject:(FREObject)obj
{
    uint32_t length;
    const uint8_t *value;
    FREGetObjectAsUTF8(obj, &length, &value);
    return [NSString stringWithUTF8String:(const char *)value];
}

// boolean值生成FREObject
- (FREObject)getFREObjectFromBool :(BOOL)objcBool
{
	FREObject returnFREobject = NULL;
	FRENewObjectFromBool(objcBool, &returnFREobject);
	return returnFREobject;
}

- (void)dealloc
{
    #ifdef DEBUG
        NSLog(@"UMengAnalyticsANE dealloc");
    #endif
    
    self.context = nil;     // 释放句柄
    [super dealloc];
}

@end

//////////////// 定义ANE的外部接口

// 启动友盟分析
ANE_FUNCTION(UMengAnalyticsStart)
{
    if (argc != 2) return [UMengAnalyticsANE_handler getFREObjectFromBool:NO];     // 参数不够3个则直接返回失败
    NSString *AppKey = [UMengAnalyticsANE_handler getStringFromFREObject:argv[0]];
    NSString *ChannelID = [UMengAnalyticsANE_handler getStringFromFREObject:argv[1]];
    if (AppKey == nil || AppKey.length<=0 || ChannelID == nil || ChannelID.length<=0) return [UMengAnalyticsANE_handler getFREObjectFromBool:NO];   // 参数不完整...
    
    NSLog(@"UMengAnalytics Start Key=%@ ChannelID=%@",AppKey,ChannelID);
    [MobClick startWithAppkey:AppKey reportPolicy:SEND_ON_EXIT channelId:ChannelID];
    
    return [UMengAnalyticsANE_handler getFREObjectFromBool:YES];           // 返回初始化成功
}


//////////////ANE 标准化接口
void UMengAnalyticsANEExtInitializer(void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet) 
{
    *extDataToSet = NULL;
    *ctxInitializerToSet = &UMengAnalyticsContextInitializer;
    *ctxFinalizerToSet = &UMengAnalyticsContextFinalizer;
}

void UMengAnalyticsANEExtFinalizer(void* extData) 
{
    return;
}

void UMengAnalyticsContextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToTest, const FRENamedFunction** functionsToSet)
{
    #ifdef DEBUG
        NSLog(@"UMengAnalyticsANE ContextInitializer()");
    #endif
    static FRENamedFunction func[] =
    {
        MAP_FUNCTION(UMengAnalyticsStart, NULL),
    };
    
    *numFunctionsToTest = sizeof(func) / sizeof(FRENamedFunction);
    *functionsToSet = func;
    
    UMengAnalyticsANE_handler = [[UMengAnalyticsANE alloc] initWithContext:ctx];
}

void UMengAnalyticsContextFinalizer(FREContext ctx)
{
    #ifdef DEBUG
        NSLog(@"UMengAnalyticsANE ContextFinalizer()...");
    #endif
    if (UMengAnalyticsANE_handler != nil) UMengAnalyticsANE_handler = nil;
    return;
}
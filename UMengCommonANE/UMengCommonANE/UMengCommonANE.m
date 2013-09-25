//
//  UMengCommonANE.m
//  UMengCommonANE
//
//  Created by Emck on 9/25/13.
//  Copyright (c) 2013 Apptem. All rights reserved.
//

#import "UMengCommonANE.h"

static UMengCommonANE* UMengCommonANE_handler;          // UMengCommonANE主句柄
static NSString *UMSocialSDKStaticComma = @",";
static NSString *UMSocialSDKdidFinishShareWithResult = @"UMSocialSDKdidFinishShareWithResult";

@interface UMengCommonANE ()

@end

@implementation UMengCommonANE
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

// 转换分号字符串为NSArry
- (NSArray *)ArrayFromString:(NSString *)ArrayString
{
    if (ArrayString == nil || ArrayString.length <=0) return nil;
    
    NSString *NewString = [ArrayString substringFromIndex: ArrayString.length -1];
    if ([NewString isEqualToString:UMSocialSDKStaticComma]) {
        NewString = [ArrayString substringToIndex:ArrayString.length -1];
        return [NewString componentsSeparatedByString:UMSocialSDKStaticComma];
    }
    else return [ArrayString componentsSeparatedByString:UMSocialSDKStaticComma];
}

// 将FREObject转成NSString
- (NSString*)getStringFromFREObject:(FREObject)obj
{
    uint32_t length;
    const uint8_t *value;
    FREGetObjectAsUTF8(obj, &length, &value);
    return [NSString stringWithUTF8String:(const char *)value];
}

// 将FREObject转成NSInteger
- (NSInteger)getNSIntegerFromFREObject :(FREObject)freObject
{
    int32_t asNumber = 0;
    FREObjectType   freObjectType = FRE_TYPE_NULL;
    FREGetObjectType(freObject, &freObjectType);
    
    assert(freObjectType == FRE_TYPE_NUMBER);
    
    if (freObjectType == FRE_TYPE_NUMBER) {
        FREGetObjectAsInt32(freObject, &asNumber);
    }
    return asNumber;
}

// boolean值生成FREObject
- (FREObject)getFREObjectFromBool :(BOOL)objcBool
{
	FREObject returnFREobject = NULL;
	FRENewObjectFromBool(objcBool, &returnFREobject);
	return returnFREobject;
}

//////////------------------------UMSocialSDK for iOS------------- Add -----
// 分享完成时的回调函数
-(void)didFinishShareWithResult:(UMSResponseCode)shareResult
{
    if (shareResult == UMSResponseCodeSuccess) {        // 分享成功
        NSLog(@"didFinishShareWithResult Success");
    }
    else {                                              // 分享失败
        NSLog(@"didFinishShareWithResult %d",shareResult);
    }
    
    NSString *message = [NSString stringWithFormat:@"{\"UMSResponseCode\":%d}",shareResult];
    
    FREDispatchStatusEventAsync(context,(const uint8_t *)[UMSocialSDKdidFinishShareWithResult UTF8String],(const uint8_t *)[message UTF8String]);
}
//////////------------------------UMSocialSDK for iOS------------- End -----


- (void)dealloc
{
    #ifdef DEBUG
        NSLog(@"UMengCommonANE dealloc");
    #endif
    
    self.context = nil;     // 释放句柄
    [super dealloc];
}

@end


//////////////// 定义ANE的外部接口

// 初始化....
ANE_FUNCTION(UMengCommonInit)
{
    if (argc != 2) return [UMengCommonANE_handler getFREObjectFromBool:NO];     // 参数不够3个则直接返回失败
    NSString *AppKey = [UMengCommonANE_handler getStringFromFREObject:argv[0]];
    NSString *ShareToSnsNames = [UMengCommonANE_handler getStringFromFREObject:argv[1]];
    if (AppKey == nil || AppKey.length<=0) return [UMengCommonANE_handler getFREObjectFromBool:NO];   // 参数不完整...
    
    [UMengCommon setAppKey:AppKey];
    
    // 设置ShareToSnsNames
    if (ShareToSnsNames != nil && ShareToSnsNames.length>0)  [UMengCommon setShareToSnsNames:[UMengCommonANE_handler ArrayFromString:ShareToSnsNames]];
    
    // 设置rootViewController和回调
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    [UMengCommon setViewAndDelegate:window.rootViewController Delegate:UMengCommonANE_handler];
    
    return [UMengCommonANE_handler getFREObjectFromBool:YES];           // 返回初始化成功
}

// 分享文字(不带图片)
ANE_FUNCTION(UMengCommonShareText)
{
    if (argc != 1) return [UMengCommonANE_handler getFREObjectFromBool:NO];
    
    NSString *ShareText =  [UMengCommonANE_handler getStringFromFREObject:argv[0]];
    if (ShareText == nil || ShareText.length<=0) return [UMengCommonANE_handler getFREObjectFromBool:NO];
    
    [[UMengCommon defaultInstance] ShareWithText:ShareText Image:nil];
    return [UMengCommonANE_handler getFREObjectFromBool:YES];       // 返回支付申请成功
}

ANE_FUNCTION(UMengCommonShareTextWithImageFile)
{
    if (argc != 2) return [UMengCommonANE_handler getFREObjectFromBool:NO];
    
    NSString *ShareText =  [UMengCommonANE_handler getStringFromFREObject:argv[0]];
    NSString *ImageFile =  [UMengCommonANE_handler getStringFromFREObject:argv[1]];
    if (ShareText == nil || ShareText.length<=0 || ImageFile == nil || ImageFile.length<=0) return [UMengCommonANE_handler getFREObjectFromBool:NO];
    
    [[UMengCommon defaultInstance] ShareWithText:ShareText ImageFileName:ImageFile];
    return [UMengCommonANE_handler getFREObjectFromBool:YES];       // 返回支付申请成功
}

ANE_FUNCTION(UMengCommonShareTextWithUrl)
{
    if (argc != 3) return [UMengCommonANE_handler getFREObjectFromBool:NO];
    
    NSString *ShareText =  [UMengCommonANE_handler getStringFromFREObject:argv[0]];
    NSString *Url =  [UMengCommonANE_handler getStringFromFREObject:argv[1]];
    NSInteger Type =  [UMengCommonANE_handler getNSIntegerFromFREObject:argv[2]];
    if (ShareText == nil || ShareText.length<=0 || Url == nil || Url.length<=0) return [UMengCommonANE_handler getFREObjectFromBool:NO];
    
    [[UMengCommon defaultInstance] ShareWithText:ShareText ResourceUrl:Url ResourceType:Type];
    return [UMengCommonANE_handler getFREObjectFromBool:YES];       // 返回支付申请成功
}

/////////////////////////////////////
//////// Air的初始化接口 由extension.xml定义
void UMengCommonANEExtInitializer(void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet)
{
    *extDataToSet = NULL;
    *ctxInitializerToSet = &UMengCommonANEContextInitializer;
    *ctxFinalizerToSet = &UMengCommonANEContextFinalizer;
}

void UMengCommonANEExtFinalizer(void* extData)
{
    return;
}

void UMengCommonANEContextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToTest, const FRENamedFunction** functionsToSet)
{
    #ifdef DEBUG
        NSLog(@"UMengCommonANE ContextInitializer()");
    #endif
    static FRENamedFunction func[] =
    {
        MAP_FUNCTION(UMengCommonInit, NULL),
        MAP_FUNCTION(UMengCommonShareText, NULL),
        MAP_FUNCTION(UMengCommonShareTextWithImageFile, NULL),
        MAP_FUNCTION(UMengCommonShareTextWithUrl, NULL),
    };
    
    *numFunctionsToTest = sizeof(func) / sizeof(FRENamedFunction);
    *functionsToSet = func;
    
    UMengCommonANE_handler = [[UMengCommonANE alloc] initWithContext:ctx];
}

void UMengCommonANEContextFinalizer(FREContext ctx)
{
    #ifdef DEBUG
        NSLog(@"UMengCommonANE ContextFinalizer()...");
    #endif
    if (UMengCommonANE_handler != nil) UMengCommonANE_handler = nil;
    return;
}
//
//  UMengCommon.m
//  UMengCommonSDK
//
//  Created by Emck on 9/24/13.
//  Copyright (c) 2013 AppTem. All rights reserved.
//

#import "UMengCommon.h"

#import "UMSocial.h"

static UMengCommon *UMengCommonInit = nil;
static NSString *UMengCommonAppKey = nil;           // 友盟平台分配的AppKey
static NSString *UMengCommonChannelID = nil;        // 友盟平台所需要的渠道ID
static NSArray *UMengCommonSocialShareToSnsNames = nil;

@implementation UMengCommon
{
    UIViewController *ParentViewController;         // 父ViewController
    
    id<UMSocialShareResult> Delegate;
}

// 获取静态实例
+ (UMengCommon*)defaultInstance
{
    if (UMengCommonInit != nil) return UMengCommonInit;
    else {
        UMengCommonInit = [[UMengCommon alloc] init];
        return UMengCommonInit;
    }
}

//// 设置友盟统计AppKey(仅需要执行一次)
+ (void)setAppKey:(NSString *)AppKey;
{
    UMengCommonAppKey = AppKey;
}

//// 设置友盟统计渠道ID(仅需要执行一次)
+ (void)setChannelID:(NSString *)ChannelID
{
    UMengCommonChannelID = ChannelID;
}

// 设置友盟社会化组件分享列表(仅需要执行一次)
+ (void)setShareToSnsNames:(NSArray *)ShareToSnsNames
{
    UMengCommonSocialShareToSnsNames = ShareToSnsNames;
}

// 设置静态实例主窗口控制器和回调委托
+ (void)setViewAndDelegate:(UIViewController *)ViewController Delegate:(id<UMSocialShareResult>)Delegate
{
    if (UMengCommonInit == nil) {
        UMengCommonInit = [[UMengCommon alloc] init];
    }
    if (ViewController == nil || Delegate == nil) {
        NSLog(@"系统异常,初始化UMengCommonSDK时ViewController或Delegate为空...");
        return;
    }
    [UMengCommonInit setParentViewController:ViewController];
    [UMengCommonInit setDelegate:Delegate];
}

/////////////////////////////////////////////////////////////////
- (id)init
{
    if (self = [super init]) {
        [self initialize];
    }
    #ifdef DEBUG
        NSLog(@"Debug:: UMengCommonSDK init by Debug Mode");
    #endif
    return self;
}

- (void)initialize
{
    [UMSocialData setAppKey:UMengCommonAppKey];         // 设置友盟AppKey
    
    //    // 仅当设置了ChannelID时才开启统计,否则仅仅是使用社会化组件
    //    if (UMengCommonChannelID != nil && UMengCommonChannelID.length >0)
    //        [MobClick startWithAppkey:UMengCommonAppKey reportPolicy:SEND_ON_EXIT channelId:UMengCommonChannelID];
}

// 设置父View
- (void)setParentViewController:(UIViewController *)ViewController
{
    ParentViewController = ViewController;
}

// 设置托管(用于回调)
- (void)setDelegate:(id<UMSocialShareResult>)delegate
{
    Delegate = delegate;
}

// 分享文字+本地图片文件
- (void)ShareWithText:(NSString *)Text ImageFileName:(NSString *)ImageFileName
{
    if (ParentViewController == nil || Text == nil) return;
    
    if (ImageFileName == nil) [self ShareWithText:Text Image:nil];
    else {
        [self ShareWithText:Text Image:[[UIImage alloc] initWithContentsOfFile:[NSHomeDirectory() stringByAppendingPathComponent:ImageFileName]]];
    }
}

// 分享文字+UIImage
- (void)ShareWithText:(NSString *)Text Image:(UIImage *)Image
{
    if (ParentViewController == nil || Text == nil) return;
    
    [UMSocialData defaultData].urlResource = nil;
        
    [UMSocialSnsService presentSnsIconSheetView:ParentViewController
                                         appKey:UMengCommonAppKey
                                      shareText:Text
                                     shareImage:Image
                                shareToSnsNames:UMengCommonSocialShareToSnsNames
                                 resultDelegate:Delegate];
}

// 分享文字+资源Url(支持视频,音乐,图片)
- (void)ShareWithText:(NSString *)Text ResourceUrl:(NSString *)ResourceUrl ResourceType:(UMSocialUrlResourceType)ResourceType
{
    if (ParentViewController == nil || Text == nil) return;
    
    [[UMSocialData defaultData].urlResource setResourceType:ResourceType url:ResourceUrl];
    
    [UMSocialSnsService presentSnsIconSheetView:ParentViewController
                                         appKey:UMengCommonAppKey
                                      shareText:Text
                                     shareImage:nil
                                shareToSnsNames:UMengCommonSocialShareToSnsNames
                                 resultDelegate:Delegate];
}

@end
//
//  UMengCommon.h
//  UMengCommonSDK
//
//  Created by Emck on 9/24/13.
//  Copyright (c) 2013 AppTem. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "UMengCommonConstants.h"

@protocol UMSocialShareResult <NSObject>

// 分享完成的回调结果
-(void)didFinishShareWithResult:(UMSResponseCode)shareResult;

@end

@interface UMengCommon : NSObject

// 初始化相关
// 设置友盟统计AppKey(仅需要执行一次)
+ (void)setAppKey:(NSString *)AppKey;

// 设置友盟统计渠道ID(仅需要执行一次)
+ (void)setChannelID:(NSString *)ChannelID;

// 设置友盟社会化组件分享列表(仅需要执行一次)
+ (void)setShareToSnsNames:(NSArray *)ShareToSnsNames;

// 设置静态实例主窗口控制器和回调委托
+ (void)setViewAndDelegate:(UIViewController *)ViewController Delegate:(id<UMSocialShareResult>)Delegate;

// 获取静态实例
+ (UMengCommon*)defaultInstance;


///////////////////////////////

// 分享文字+本地图片文件
- (void)ShareWithText:(NSString *)Text ImageFileName:(NSString *)ImageFileName;

// 分享文字+UIImage
- (void)ShareWithText:(NSString *)Text Image:(UIImage *)Image;

// 分享文字+资源Url(支持视频,音乐,图片)
- (void)ShareWithText:(NSString *)Text ResourceUrl:(NSString *)ResourceUrl ResourceType:(UMSocialUrlResourceType)ResourceType;

@end
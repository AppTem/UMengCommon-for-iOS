//
//  UMengCommonConstants.h
//  UMengCommonSDK
//
//  Created by Emck on 9/25/13.
//  Copyright (c) 2013 Apptem. All rights reserved.
//

#ifndef UMengCommonSDK_UMengCommonConstants_h
#define UMengCommonSDK_UMengCommonConstants_h

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-variable"                    // 忽略未使用的变量警告错误
static const NSString *UMengCommonSocialShareToSina = @"sina";
static const NSString *UMengCommonSocialShareToTencent = @"tencent";
static const NSString *UMengCommonSocialShareToRenren = @"renren";
static const NSString *UMengCommonSocialShareToDouban = @"douban";
static const NSString *UMengCommonSocialShareToQzone = @"qzone";
static const NSString *UMengCommonSocialShareToEmail = @"email";
static const NSString *UMengCommonSocialShareToSms = @"sms";
static const NSString *UMengCommonSocialShareToWechat = @"wechat";
static const NSString *UMengCommonSocialShareToWechatSession = @"wxsession";
static const NSString *UMengCommonSocialShareToWechatTimeline = @"wxtimeline";
static const NSString *UMengCommonSocialShareToFacebook = @"facebook";
static const NSString *UMengCommonSocialShareToTwitter = @"twitter";
#pragma clang diagnostic pop


/** 网络请求结果状态码 */
typedef enum {
    UMSResponseCodeSuccess            = 200,        //成功
    UMSResponseCodeBaned              = 505,        //用户被封禁
    UMSResponseCodeFaild              = 510,        //发送失败（由于内容不符合要求或者其他原因）
    UMSResponseCodeEmptyContent       = 5007,       //发送内容为空
    UMSResponseCodeShareRepeated      = 5016,       //分享内容重复
    UMSResponseCodeGetNoUidFromOauth  = 5020,       //授权之后没有得到用户uid
    UMSResponseCodeAccessTokenExpired = 5027,       //token过期
    UMSResponseCodeNetworkError       = 5050,       //网络错误
    UMSResponseCodeGetProfileFailed   = 5051,       //获取账户失败
    UMSResponseCodeCancel             = 5052,        //用户取消授权
    UMSResponseCodeNoApiAuthority     = 100031      //QQ空间应用没有在QQ互联平台上申请上传图片到相册的权限
} UMSResponseCode;

typedef enum {
    UMSocialUrlResourceTypeImage,               //图片
    UMSocialUrlResourceTypeVideo,               //视频
    UMSocialUrlResourceTypeMusic                //音乐
}UMSocialUrlResourceType;


#endif
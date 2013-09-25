package com.apptem.umengcommon
{
	/**
	 * 常量对象
	 * Emck 友盟社会化组件
	 */	
	public class Constants
	{
		//原生函数列表
		internal static const UMengCommonInit : String = "UMengCommonInit";										// 初始化
		internal static const UMengCommonShareText : String = "UMengCommonShareText";							// 分享文字
		internal static const UMengCommonShareTextWithImageFile : String = "UMengCommonShareTextWithImageFile";	// 分享文字+本地图片
		internal static const UMengCommonShareTextWithUrl : String = "UMengCommonShareTextWithUrl";				// 分享文字+网络资源
		internal static const UMengCommonhandleOpenURL : String = "UMengCommonhandleOpenURL";						// 社会化组件回调事件

		// 事件标识
		public static const didFinishShareWithResult : String = "UMSocialSDKdidFinishShareWithResult";

		//分享目标
		public static const UMSocialShareToSina : String = "sina,";
		public static const UMSocialShareToTencent : String = "tencent,";
		public static const UMSocialShareToRenren : String = "renren,";
		public static const UMSocialShareToDouban : String = "douban,";
		public static const UMSocialShareToQzone : String = "qzone,";
		public static const UMSocialShareToEmail : String = "email,";
		public static const UMSocialShareToSms : String = "sms,";
		public static const UMSocialShareToWechat : String = "wechat,";
		public static const UMSocialShareToWechatSession : String = "wxsession,";
		public static const UMSocialShareToWechatTimeline : String = "wxtimeline,";
		public static const UMSocialShareToFacebook : String = "facebook,";
		public static const UMSocialShareToTwitter : String = "twitter,";
		
		//分享资源Url类型
		public static const UMSocialUrlResourceTypeImage : int = 0;	//图片
		public static const UMSocialUrlResourceTypeVideo : int = 1;	//视频
		public static const UMSocialUrlResourceTypeMusic : int = 2;	//音乐
		
		// UMSocialResponseCode
		public static const UMSResponseCodeSuccess :int             = 200;        //成功
		public static const	UMSResponseCodeBaned :int               = 505;        //用户被封禁
		public static const	UMSResponseCodeFaild :int               = 510;        //发送失败（由于内容不符合要求或者其他原因）
		public static const	UMSResponseCodeEmptyContent :int        = 5007;       //发送内容为空
		public static const	UMSResponseCodeShareRepeated :int       = 5016;       //分享内容重复
		public static const	UMSResponseCodeGetNoUidFromOauth :int   = 5020;       //授权之后没有得到用户uid
		public static const	UMSResponseCodeAccessTokenExpired :int  = 5027;       //token过期
		public static const	UMSResponseCodeNetworkError :int        = 5050;       //网络错误
		public static const	UMSResponseCodeGetProfileFailed :int    = 5051;       //获取账户失败
		public static const	UMSResponseCodeCancel :int              = 5052;       //用户取消授权
		public static const	UMSResponseCodeNoApiAuthority :int      = 100031;     //QQ空间应用没有在QQ互联平台上申请上传图片到相册的权限
		
	}
}
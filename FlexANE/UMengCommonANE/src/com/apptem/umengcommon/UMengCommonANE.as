package com.apptem.umengcommon
{
	import flash.desktop.NativeApplication;
	import flash.events.EventDispatcher;
	import flash.events.InvokeEvent;
	import flash.events.StatusEvent;
	import flash.external.ExtensionContext;
	
	/**
	 * 友盟平台公共ANE接口
	 * Emck AppTem.com
	 */
	public class UMengCommonANE extends EventDispatcher
	{
		private var extContext:ExtensionContext = null;		// 保存外部扩展实例
		public static var Instance:UMengCommonANE;			// 当前对象UMengCommonANE的单实例
		
		/**
		 * UMengCommonANE 初始化
		 */
		public function UMengCommonANE(listener:Function,AppKey:String,ShareToSnsNames:String)
		{
			super();
			if (extContext == null) {
				// 创建本地化接口
				extContext = ExtensionContext.createExtensionContext("com.apptem.umengcommon", null);
				// 监听并转发事件
				extContext.addEventListener(StatusEvent.STATUS, statusHandler);		// 监听iOS接口的事件
				this.addEventListener(StatusEvent.STATUS, listener);				// 注册回调事件
				// 调用本地化接口初始化方法
				if ((extContext.call(Constants.UMengCommonInit,AppKey,ShareToSnsNames) as Boolean) == false) {	// 调用iOS接口初始化
					trace("初始化UMengCommonSDK ANE接口失败");
				}
				// 注册监听iOS handleOpenURL事件 -- (UIApplication *)application handleOpenURL:(NSURL *)url
				NativeApplication.nativeApplication
					.addEventListener(InvokeEvent.INVOKE,
						function invokeHandler(event:InvokeEvent):void{
							if ( event.arguments.length>0) {
								extContext.call(Constants.UMengCommonhandleOpenURL,event.arguments[0]);
							}
						});
			}
		}
		
		/**
		 * 分享文字
		 * String ShareText 待分享的文字内容
		 * @return 分享请求成功返回true,否则返回false
		 */
		public function doShareText(ShareText:String):Boolean
		{
			return extContext.call(Constants.UMengCommonShareText,ShareText) as Boolean;
		}
		
		/**
		 * 分享文字+本地图片
		 * String ShareText 待分享的文字内容
		 * String ImageFileName 待分享的本地图片
		 * @return 分享请求成功返回true,否则返回false
		 */
		public function doShareTextWithImageFile(ShareText:String,ImageFileName:String):Boolean
		{
			return extContext.call(Constants.UMengCommonShareTextWithImageFile,ShareText,ImageFileName) as Boolean;
		}
		
		/**
		 * 分享文字+本地图片
		 * String ShareText 待分享的文字内容
		 * String ImageFileName 待分享的本地图片
		 * @return 分享请求成功返回true,否则返回false
		 */
		public function doShareTextWithUrl(ShareText:String,SourceUrl:String,SourceType:int):Boolean
		{
			return extContext.call(Constants.UMengCommonShareTextWithUrl,ShareText,SourceUrl,SourceType) as Boolean;
		}
		
		/**
		 * 把iOS的事件交给AIR主程序来处理
		 */
		private function statusHandler(event:StatusEvent):void
		{
			if (event.code == Constants.didFinishShareWithResult) {	// didFinishShareWithResult
				dispatchEvent(event);								// 派发事件给ANE的使用者
			}
			// 不识别的事件直接忽略
		}
		
		/**
		 * 初始化UMengCommonANE实例,仅在启动时调用一次即可
		 * @return 返回UMengCommonANE的单实例
		 */
		public static function Init(listener:Function,AppKey:String,ShareToSnsNames:String = null):UMengCommonANE
		{
			if (Instance == null) Instance = new UMengCommonANE(listener,AppKey,ShareToSnsNames);
			return Instance;
		}
	}
}
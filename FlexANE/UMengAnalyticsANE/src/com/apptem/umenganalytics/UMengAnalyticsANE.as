package com.apptem.umenganalytics
{
	import flash.events.EventDispatcher;
	import flash.external.ExtensionContext;
	
	public class UMengAnalyticsANE extends EventDispatcher
	{	
		private var extContext:ExtensionContext = null;		// 保存外部扩展实例
		private static var Instance:UMengAnalyticsANE;		// 当前对象UMengAnalyticsANE的单实例

		public function UMengAnalyticsANE(AppKey:String,ChannelID:String)
		{
			super();
			if (extContext == null) {
				// 创建本地化接口
				extContext = ExtensionContext.createExtensionContext("com.apptem.umenganalytics", null);
			}
		}
		
		/**
		 * 启动友盟分析,仅在启动时调用一次即可
		 * @return 返回UMengCommonANE的单实例
		 */
		public static function StartAnalytics(AppKey:String,ChannelID:String):Boolean
		{
			if (Instance != null) return false;
			else {
				Instance = new UMengAnalyticsANE(AppKey,ChannelID);
				// 调用本地化接口初始化方法
				if ((Instance.extContext.call("UMengAnalyticsStart",AppKey,ChannelID) as Boolean) == false) {	// 调用iOS接口
					trace("初始化UMengAnalytics ANE接口失败");
					return false;
				}
				else return true;
			}
		}
	}
}
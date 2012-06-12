package code {
	
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.events.*;
	import com.sina.microblog.MicroBlog;
	import com.sina.microblog.events.*;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.utils.ByteArray;
	import com.adobe.images.JPGEncoder;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	import com.greensock.TweenLite; 
	import com.greensock.plugins.TweenPlugin; 
	import com.greensock.plugins.TransformAroundCenterPlugin;
	import com.greensock.TweenMax;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.display.Loader;
	import flash.utils.Timer;

	
	public class step4 extends MovieClip {
		
		private var _mb:MicroBlog;
		private var _bytearrayImg:ByteArray;
		private var _saveBmpdata:BitmapData;
		private var _matrix:Matrix;
		private var _loader:Loader;
		private var myTimer:Timer;
		
		private var weiCon:String;
		public var numPic:String;
		private var choState:int = 0;
		private var weiboStr:String = " 快来看看你是哪种人吧！ http://creditcard.bankcomm.com/bcms/index.htm";
		
		public function step4() {
			// constructor code
			if (stage) {
				init();
			}else {
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
			
			
		}
		
		private function init(e:Event=null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			//this.visible = false;
			//this.alpha = 0;
			
			_mb = new MicroBlog();
			_mb.consumerKey = "4081343433";
			_mb.consumerSecret = "595001193af94521457d1f8334c33a9b";
			//_mb.proxyURI = "http://www.digitalcn.net/proxy.php";
			_mb.proxyURI = "http://rickshy.sinaapp.com/proxy.php";
			
			tip.alpha =0;
			tip.visible = false;
			
			//System.useCodePage = false;
			
		}
		public function setLogin():void 
		{
			_mb.addEventListener(MicroBlogEvent.LOGIN_RESULT, onLoginResult);
			_mb.login();
		}
		public function setPic(str:String) {
			
			
			switch(str) {
				case "1":
					weiCon = "洒脱不拘、超凡脱俗，自然大方，不呆板，不拘束，接受我改变不了的，改变我能力所及的，潇洒，可以使男人更加有魅力。"+weiboStr;
					loadPic("weibo/boy/1.jpg");
					mcName.gotoAndStop(1);
					break;
				case "2":
					weiCon = "头发散乱或是很油亮？衣着简单、不修边幅？整天窝在家内不出门？纯宅、虚无宅、二次元宅、萌宅、电脑宅、技术宅、眼镜宅各种宅。宅让你自得其乐。"+weiboStr;
					loadPic("weibo/boy/2.jpg");
					mcName.gotoAndStop(2);
					break;
				case "3":
					weiCon = "很多人都以为我天生吃不胖，但我想没有小心翼翼的保养，也不太可能一直维持健康有型的身材。型男的品位可以不时髦但一定要出众， 要尽量地活出自己的特色。型男是新一代魅力的男生。"+weiboStr;
					loadPic("weibo/boy/3.jpg");
					mcName.gotoAndStop(3);
					break;
				case "4":
					weiCon = "把可以不耗费的减省下来，因网络红人“猥琐男”的出现，将猥琐推到了时尚前沿。猥琐也成为了一种新的生活方式。让我们把抠门猥琐到底。"+weiboStr;
					loadPic("weibo/boy/4.jpg");
					mcName.gotoAndStop(4);
					break;
			}
			
		}
		public function loadPic(url:String):void 
		{
				_loader = new Loader();
				_loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onLoadPicHandle);
				_loader.load(new URLRequest(url));
		}
		
		private function onLoadPicHandle(e:Event):void 
		{
			imgloader.addChild(_loader);
			TweenLite.from(_loader, .3, { alpha:0 } );

		}
		private function onRollHandle(e:Event):void 
		{
			var str:String = e.type;
			switch(str) {
				case "rollOut":
					Mouse.cursor = MouseCursor.ARROW;
					break;
				case "rollOver":
					
					Mouse.cursor = MouseCursor.BUTTON;
					break;
			}
		}
		
		protected function btnLogin_clickHandler(event:MouseEvent):void
		{
			_mb.addEventListener(MicroBlogEvent.LOGIN_RESULT, onLoginResult);
			_mb.login();
			
		}
		protected function onLoginResult(e:MicroBlogEvent):void
		{
			_mb.removeEventListener(MicroBlogEvent.LOGIN_RESULT, onLoginResult);
			
			//TweenMax.to(btnUpdate, .5, { autoAlpha:1 } );

			btnUpdate.addEventListener(MouseEvent.CLICK, onUpdateHandle);
			btnUpdate.addEventListener(MouseEvent.ROLL_OUT, onRollHandle);
			btnUpdate.addEventListener(MouseEvent.ROLL_OVER, onRollHandle);
			
			
			btnUpdateShop.addEventListener(MouseEvent.CLICK, onUpdateShopHandle);
			btnUpdateShop.addEventListener(MouseEvent.ROLL_OUT, onRollHandle);
			btnUpdateShop.addEventListener(MouseEvent.ROLL_OVER, onRollHandle);

			btnCho.addEventListener(MouseEvent.CLICK, onChoHandle);
			btnCho.addEventListener(MouseEvent.ROLL_OUT, onRollHandle);
			btnCho.addEventListener(MouseEvent.ROLL_OVER, onRollHandle);
						
			//TweenMax.to(this, .5, { autoAlpha:1 } );
			
			setPic(numPic);
			
			stage.dispatchEvent(new Event("mc3"));
			
		}
		private function onChoHandle(e:MouseEvent):void{
			if(choState == 0){
				e.currentTarget.gotoAndStop(2);
				choState = 1;
			}else{
				e.currentTarget.gotoAndStop(1);
				choState = 0;
			}
			trace(choState);
		}
		private function onUpdateShopHandle(e:MouseEvent):void 
		{
			btnUpdateShop.removeEventListener(MouseEvent.CLICK, onUpdateShopHandle);
			if(roadName.text != ""){
				
				var str:String = roadName.text + " @身边实惠 来查看周围的特惠商户";
					//str = encodeURIComponent(str);
				_mb.updateStatus(str.toString(),null);
				//test.text = str;
				
				_mb.addEventListener(MicroBlogEvent.UPDATE_STATUS_RESULT, mb_onUpdate);
				_mb.addEventListener(MicroBlogErrorEvent.UPDATE_STATUS_ERROR, mb_onError);
			
			}else{
				tip.txt.text = "请输入路名!";
				tip.x = 10;
				TweenMax.to(tip,.5,{x:38.3,autoAlpha:1});
				TweenMax.to(tip,.5,{autoAlpha:0,x:80,delay:2,onComplete:function(){
							btnUpdateShop.addEventListener(MouseEvent.CLICK, onUpdateShopHandle);
							}});
			}
			
		}
		private function onUpdateHandle(e:MouseEvent):void 
		{
			if(choState == 1){
				_mb.follow("2052879865");
				//_mb.addEventListener(MicroBlogEvent.FOLLOW_STATUS_RESULT, mb_onFollow);
				//_mb.addEventListener(MicroBlogErrorEvent.FOLLOW_STATUS_ERROR, mb_FollowError);
			}
			
			tip.txt.text = "正在分享，请稍候！";
			
			btnUpdate.removeEventListener(MouseEvent.CLICK, onUpdateHandle);
			var JPGcoder:JPGEncoder = new JPGEncoder(80);
			var wid:Number = imgloader.width;
			var het:Number = imgloader.height;
			_saveBmpdata=new BitmapData(wid,het);
			_matrix = null;
			_matrix = new Matrix();
			_saveBmpdata.draw(imgloader,_matrix,null,null,null,true);
			_bytearrayImg=JPGcoder.encode(_saveBmpdata);
			
			_mb.updateStatus(weiCon,_bytearrayImg);
			
			_mb.addEventListener(MicroBlogEvent.UPDATE_STATUS_RESULT, mb_onUpdate);
			_mb.addEventListener(MicroBlogErrorEvent.UPDATE_STATUS_ERROR, mb_onError);
			tip.x = 10;
			TweenMax.to(tip,.5,{x:38.3,autoAlpha:1});
			
		}
		
		private function mb_FollowError(e:MicroBlogErrorEvent):void 
		{
			 //tip.txt.text = "分享失败！";
			 tip.txt.text = e.message;
			 tip.x = 10;
			 TweenMax.to(tip,.5,{x:38.3,autoAlpha:1});
			 //TweenMax.to(tip,.5,{autoAlpha:0,x:80,delay:2});
			 
			btnUpdateShop.addEventListener(MouseEvent.CLICK, onUpdateShopHandle);
			btnUpdate.addEventListener(MouseEvent.CLICK, onUpdateHandle);
			
		}
		
		private function mb_onFollow(e:MicroBlogEvent):void 
		{
			
		}
		
		private function mb_onError(e:MicroBlogErrorEvent):void 
		{
			 tip.txt.text = "分享失败！";
			 tip.x = 10;
			 TweenMax.to(tip,.5,{x:38.3,autoAlpha:1});
			 TweenMax.to(tip,.5,{autoAlpha:0,x:80,delay:2});
			 
			btnUpdateShop.addEventListener(MouseEvent.CLICK, onUpdateShopHandle);
			btnUpdate.addEventListener(MouseEvent.CLICK, onUpdateHandle);
		}
		
		private function mb_onUpdate(e:MicroBlogEvent):void 
		{
			btnUpdateShop.addEventListener(MouseEvent.CLICK, onUpdateShopHandle);
			tip.txt.text = "分享成功！快去微博看看吧！";
			tip.x = 10;
			TweenMax.to(tip,.5,{x:38.3,autoAlpha:1});
			TweenMax.to(tip,.5,{autoAlpha:0,x:80,delay:2});
		}
	}
	
}

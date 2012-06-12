package code {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	import com.greensock.TweenMax;	
	import com.greensock.easing.*;
	import flash.text.TextFormat;
	import flash.text.TextField;
	
	public class gstep1 extends MovieClip {
		private var xmlData:XML;
		private var txt:TextField;
		public function gstep1() {
			if (stage) {
				init();
			}else {
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
		}
		
		private function init(e:Event=null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
		
			
			
			btnCho.addEventListener(MouseEvent.CLICK, onNextHandle);
			
			btnCho.addEventListener(MouseEvent.ROLL_OVER, onRollHandle);
			
			btnCho.addEventListener(MouseEvent.ROLL_OUT, onRollHandle);
			
			loadxml("title.xml");
			
		}
		private function loadxml(Url:String):void 
		{
			var _urlLoader:URLLoader = new URLLoader();
			var _urlRequest:URLRequest = new URLRequest(Url);
			_urlLoader.addEventListener(Event.COMPLETE,onTitleComHandler);
			_urlLoader.load(_urlRequest);

		}
		private function onTitleComHandler(e:Event):void 
		{
			xmlData = new XML(e.target.data);
			btnCho.subTitle.htmlText = xmlData.btitle.subtitle[0];
			//setAni(0);
		}
		private function onRollHandle(e:MouseEvent):void {
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
		
		private function onNextHandle(e:MouseEvent):void 
		{
			TweenMax.to(btnCho, 0.5, { x:-480, ease:Sine.easeIn} );
			
			TweenMax.to(subBoy, 0.5, { x:747, ease:Sine.easeOut, onComplete:function() {
				
				
			var TEvent:TChangeEvent = new TChangeEvent(TChangeEvent.TNEXT);
				
			dispatchEvent(TEvent);
				
				
			}} );

		}
		
		public function setAni(num:int):void 
		{
			subBoy.x = 424.45; 
			btnCho.x = 0;
		
			if(num != 0){
				btnCho.subTitle.htmlText = xmlData.btitle.subtitle[num];
			}
		
			//btnCho.subTitle.htmlText = xmlData.gtitle.subtitle[num];
			TweenMax.from(subBoy, 0.5, { x:747, ease:Sine.easeOut } );
			TweenMax.from(btnCho, 0.5, { x:-480, ease:Sine.easeIn } );
		}
	}
	
}

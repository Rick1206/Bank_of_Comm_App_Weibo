package code {
	
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	import com.greensock.TweenMax;
	import flash.net.URLRequest;
	import flash.net.URLLoader;
	import flash.utils.Timer;
	import com.greensock.plugins.TweenPlugin; 
	import com.greensock.plugins.TransformAroundCenterPlugin;
	
	
	public class gstep2 extends MovieClip {
		
		private var ansArray:Array;
		private var _xmldata:XML;
		private var ansNum:int=0;
		private var an1:int=0;
		private var an2:int=0;
		private var an3:int=0;
		private var an4:int = 0;
		private var mytimer:Timer;
		private var mytimer2:Timer;
		
		public function gstep2() {
			if (stage) {
				init();
			}else {
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
		}
		
		public function setInit():void {
			loadxml("girldata.xml");
		}
		private function init(e:Event=null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			TweenPlugin.activate([TransformAroundCenterPlugin]); 
			
			
			
			subBoy2.visible = false;
			subBoy2.alpha = 0;
			
			ansArray = [ans1,ans2,ans3,ans4];
			
			
			for ( var key:String in  ansArray) {
				ansArray[key].alpha = 0;
				ansArray[key].visible = false;
			}
			
			
		}
		private function removeEvent() {
			
			for (var key:String in ansArray) {
				
				ansArray[key].removeEventListener(MouseEvent.CLICK, onAnsHandle);
				
			}
			
		}
		
		private function addEvent() {
			
			for (var key:String in ansArray) {
				
				ansArray[key].addEventListener(MouseEvent.CLICK, onAnsHandle);
				
			}
			
		}
		private function loadxml(Url:String):void 
		{
			var _urlLoader:URLLoader = new URLLoader();
			var _urlRequest:URLRequest = new URLRequest(Url);
			_urlLoader.addEventListener(Event.COMPLETE,onAnsComHandler);
			_urlLoader.load(_urlRequest);

		}
		
		private function onAnsComHandler(e:Event):void 
		{
				_xmldata = XML(e.target.data);
				setAns(ansNum);
		}
		
		public function setAns(num:int):void 
		{
			removeEvent();
			TweenMax.to(subBoy2, .5, { autoAlpha:1 ,y:248,delay:.8} );
			for ( var key:String in  ansArray) {
					ansArray[key].txt.text = _xmldata.ans[num].subans[key].content;
					ansArray[key].loadPic(_xmldata.ans[num].subans[key].img);
					
					ansArray[key].addEventListener(MouseEvent.ROLL_OUT, onAnsRollHandle);
					ansArray[key].addEventListener(MouseEvent.ROLL_OVER, onAnsRollHandle);
					TweenMax.to(ansArray[key], .5, { autoAlpha:1, delay:int(key) * .3  } );
					
				}
			mytimer = new Timer((int(4) * 3) * 100, 1);
			mytimer.addEventListener(TimerEvent.TIMER, onTimerHandle);
			mytimer.start();
		}
		
		private function onTimerHandle(e:TimerEvent):void 
		{
			
			addEvent();
			mytimer = null;
		}
		
		public function setAni():void 
		{
			TweenMax.to(subBoy2, .5, { autoAlpha:1 ,y:248} );
			
			for (var key:String in ansArray) {
				TweenMax.to(ansArray[key], .5, { autoAlpha:1, delay:int(key) * .3 } );

			}
			
		}
		
		private function onAnsRollHandle(e:MouseEvent):void {
			var str:String = e.type;
			switch(str) {
				case "rollOut":
					TweenMax.to(e.currentTarget.mainLoader, .3,  {transformAroundCenter:{scale:1}});
					Mouse.cursor = MouseCursor.ARROW;
					break;
				case "rollOver":
					TweenMax.to(e.currentTarget.mainLoader, .3,  {transformAroundCenter:{scale:1.05}});
					Mouse.cursor = MouseCursor.BUTTON;
					break;
			}
		}
		
		private function onAnsHandle(e:MouseEvent):void 
		{
			
			removeEvent();
			
			var str:String = e.currentTarget.name;
			switch(str) {
				case "ans1":
					
					an1++;
					break;
				case "ans2":
					an2++;
				
					break;
				case "ans3":
					an3++;
					
					break;
				case "ans4":
				
					an4++;
					break;
			}
				
				
					
				for (var key:String in ansArray) {
					var i:int =0;
					TweenMax.allTo([ansArray[key],ansArray[key].mainLoader], .5, { autoAlpha:0 , onComplete:function() {
							
						}} );
				}
				TweenMax.to(subBoy2, .5, { autoAlpha:0} );
				
				mytimer2 = new Timer(500, 1);
				mytimer2.addEventListener(TimerEvent.TIMER, onNextHandle);
				mytimer2.start();
				
				var TEvent:TChangeEvent = new TChangeEvent(TChangeEvent.TNEXT);
				
				dispatchEvent(TEvent);
				
		}
		
		private function onNextHandle(e:TimerEvent):void 
		{
			mytimer2 = null;
			ansNum++;
			if (ansNum == _xmldata.ans.length()) {
				TweenMax.to(subBoy2, .5, { autoAlpha:0} );
				var TEvent:TChangeEvent = new TChangeEvent(TChangeEvent.TANS);
					TEvent.ansArr = [{index:1,sc:an1},{index:2,sc:an2},{index:3,sc:an3},{index:4,sc:an4}];
					dispatchEvent(TEvent);
			}	
			//}else {
				//setAns(ansNum);
						
			//}
		}
	}
	
}

package code {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	import com.greensock.TweenMax;	
	
	public class gstep3 extends MovieClip {
		private var allScore:int;
		private var perArray:Array;
		private var _arr:Array;
		public function gstep3() {
			if (stage) {
				init();
			}else {
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
		}
		
		private function init(e:Event=null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			subBoy3.visible = false;
			subBoy3.alpha = 0;
			
			perArray = [mainScore.per1,mainScore.per2,mainScore.per3,mainScore.per4];
		}
		
		
		
		public function setAni():void 
		{
			TweenMax.to(subBoy3, .5, { autoAlpha:1, y:193 } );
			TweenMax.to(mainScore, .5, { autoAlpha:1, x:368 } );
			
			
			subBoy3.btnWeibo.addEventListener(MouseEvent.CLICK, onWeiboHandle);
			subBoy3.btnWeibo.addEventListener(MouseEvent.ROLL_OUT, onRollHandle);
			subBoy3.btnWeibo.addEventListener(MouseEvent.ROLL_OVER, onRollHandle);
		}
		
		private function onWeiboHandle(e:MouseEvent):void 
		{
			var TEvent:TChangeEvent = new TChangeEvent(TChangeEvent.TWEI);
					//TEvent.ansArr = [an1,an2,an3,an4];
					
					_arr.sortOn("sc", Array.NUMERIC);
					var len:int = _arr.length-1;
					//trace(_arr[len].index);
					//trace(_arr[len].sc);
					var str:String = String(_arr[len].index);
					TEvent.weibo = str;
					dispatchEvent(TEvent);
		}
		
		
		public function setScore(arr:Array):void 
		{
			_arr = arr;
			for (var key:String in arr) {
				allScore += arr[key].sc;
				
				
			}
			
			for (key in perArray) {
				
				perArray[key].mcline.width = 120 * arr[key].sc / allScore ;
				
				perArray[key].txt.text = String(int(arr[key].sc / allScore * 1000) * .1)+"%";
			}
			
			
			
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
	}
	
}

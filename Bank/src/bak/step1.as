package code {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	import com.greensock.TweenMax;	
	
	public class step1 extends MovieClip {
		private var _num:String;
		private  var btnArray:Array;
		
		public function step1() {
			if (stage) {
				init();
			}else {
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
		}
		
		private function init(e:Event=null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
		
			
			setBtn();
		}
		
		private function setBtn():void 
		{
				btnArray = [subBg2.btncho1, subBg2.btncho2, subBg2.btncho3, subBg2.btncho4, subBg2.btncho5,subBg2.btncho6];
				
				for (var key:String in btnArray) {
				btnArray[key].addEventListener(MouseEvent.CLICK, onClickHandle);
				btnArray[key].addEventListener(MouseEvent.ROLL_OUT, onRollHandle);
				btnArray[key].addEventListener(MouseEvent.ROLL_OVER, onRollHandle);
			}
		}
		
		private function onClickHandle(e:Event):void 
		{
			var str:String = e.currentTarget.name;
			var TEvent:TChangeEvent = new TChangeEvent(TChangeEvent.TCHO);				
				
			switch(str) {
				case "btncho1":
					TEvent.num = "1";
					break;
				case "btncho2":
					TEvent.num = "2";
					break;
				case "btncho3":
					TEvent.num = "3";
					break;
				case "btncho4":
					TEvent.num = "4";
					break;
				case "btncho5":
					TEvent.num = "5";
					break;
				case "btncho6":
					TEvent.num = "6";
					break;
			}
			dispatchEvent(TEvent);
			
			TweenMax.to(subBg2, .8, { autoAlpha:0 , x: -450 } );
			TweenMax.to(subBoy, .5, { autoAlpha:0 , x:760, delay:.3 } );
		}
		private function onRollHandle(e:Event):void 
		{
			var str:String = e.type;
			switch(str) {
				case "rollOut":
					e.currentTarget.gotoAndStop(1);
					Mouse.cursor = MouseCursor.ARROW;
					break;
				case "rollOver":
					e.currentTarget.gotoAndStop(2);
					Mouse.cursor = MouseCursor.BUTTON;
					break;
			}
		}
		
		public function get num():String 
		{
			return _num;
		}
		
		public function set num(value:String):void 
		{
			_num = value;
		}
		
		
	}
	
}

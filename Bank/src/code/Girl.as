package code {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	import com.greensock.TweenMax;
	import code.TChangeEvent;
	
	public class Girl extends MovieClip {
		private var btnArray:Array;
		private var ansArray:Array;
		private var num:int;
		
		public function Girl() {
			if (stage) {
				init();
			}else {
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
		}
		
		private function init(e:Event=null):void 
		{
			
			stage.addEventListener("mc3", onMc4Handle);
			
			mc4.alpha = 0;
			mc4.visible = false;
			
			mc1.addEventListener(TChangeEvent.TNEXT, onNextHandle);
			
			mc2.addEventListener(TChangeEvent.TNEXT, onMc2NextHandle);
			mc2.addEventListener(TChangeEvent.TANS, onAnsHandle);
			
			mc3.addEventListener(TChangeEvent.TWEI, onWeiHandle);
			
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
		}
		
		private function onMc2NextHandle(e:TChangeEvent):void 
		{
			num++;
			if(num<3){
				mc1.setAni(num);
			}
		}
		private function onMc4Handle(e:Event):void 
		{
			
			TweenMax.to(mc3, .5, { autoAlpha:0 } );
			//TweenMax.to(mainbg, .5, { autoAlpha:0 , onComplete:function() {
				TweenMax.to(mc4, .5, { autoAlpha:1 } );
				//}} );
		}
		
		private function onWeiHandle(e:TChangeEvent):void 
		{
			
			mc4.setLogin();
			mc4.numPic = e.weibo;	
		}
		
		private function onNextHandle(e:TChangeEvent):void 
		{
			
			mc2.setInit();
		}
		private function onAnsHandle(e:TChangeEvent):void 
		{
			stage.dispatchEvent(new Event('removesublogo'));
			mc3.setScore(e.ansArr);
			mc3.setAni();	
		}
		
	}
	
}

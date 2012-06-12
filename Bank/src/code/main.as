package code {
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.geom.Matrix;
	import flash.utils.ByteArray;
	import com.adobe.images.JPGEncoder;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	import com.greensock.easing.*;
	import com.greensock.TweenLite; 
	import com.greensock.plugins.TweenPlugin; 
	import com.greensock.plugins.TransformAroundCenterPlugin;
	import com.greensock.TweenMax;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.display.Loader;
	
	public class main extends MovieClip {
		
		private var loader:Loader;
		private var url:URLRequest;
		private var _load:Loader;
		private var _bytearrayImg:ByteArray;
		private var _saveBmpdata:BitmapData;
		private var _matrix:Matrix;
		
		public function main() {
			if (stage) {
				init();
			}else {
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
		}
		
		private function init(e:Event = null):void 
		{
			
			stage.addEventListener("Boy", changeSwf);
			stage.addEventListener("Girl", changeSwf);
			loading.visible = false;

			TweenPlugin.activate([TransformAroundCenterPlugin]); 
			TweenMax.from(mcBoy, .8, { x: -260,delay:0.5, ease:Expo.easeOut} );
			TweenMax.from(mcGirl, .8, { x:770,delay:1, ease:Expo.easeOut,onComplete:addBtn} );
			
			
			TweenMax.to(sublogo, 1, { alpha:1, scaleX:1, scaleY:1, ease:Elastic.easeOut, delay:2 } );
			
			stage.addEventListener("removesublogo", onRemoveLogoHandle);
			//TweenMax.to(sublogo, 2, { rotationY:-8, repeat: -1, yoyo:true,delay:3} );
		}
		
		private function onRemoveLogoHandle(e:Event):void 
		{
			TweenMax.to(sublogo, 1, { autoAlpha:0 } );
		}
		
		private function addBtn():void 
		{
			mcBoy.addEventListener(MouseEvent.CLICK, onBtnClickHandle);
			mcGirl.addEventListener(MouseEvent.CLICK, onBtnClickHandle);
			
			mcBoy.addEventListener(MouseEvent.ROLL_OUT, onBtnRollHandle);
			mcBoy.addEventListener(MouseEvent.ROLL_OVER, onBtnRollHandle);
			
			mcGirl.addEventListener(MouseEvent.ROLL_OUT, onBtnRollHandle);
			mcGirl.addEventListener(MouseEvent.ROLL_OVER, onBtnRollHandle);
			
		}
		private function onlogoRollHandle(e:MouseEvent):void 
		{
			var str:String = e.type;
			switch(str) {
				case "rollOut":
					
					TweenLite.to(e.currentTarget, .3, {scaleX:1, scaleY:1, ease:Expo.easeOut }); 
					break;
				case "rollOver":
					
					TweenLite.to(e.currentTarget, .3, {scaleX:1.1, scaleY:1.1, ease:Expo.easeIn}); 
					break;
			}
		}
	
		private function changeSwf(e:Event) {
			
			mcBoy.removeEventListener(MouseEvent.ROLL_OUT, onBtnRollHandle);
			mcBoy.removeEventListener(MouseEvent.ROLL_OVER, onBtnRollHandle);
		
			mcGirl.removeEventListener(MouseEvent.ROLL_OUT, onBtnRollHandle);
			mcGirl.removeEventListener(MouseEvent.ROLL_OVER, onBtnRollHandle);
			
			TweenMax.to(mcBoy, .5, { x: -260, autoAlpha:0 } );
			
			TweenMax.to(mcGirl, .5, { x:770, autoAlpha:0 } );
			
			
			loading.visible = true;
			switch (e.type){
				case "Boy":
					SwfChange("Boy");
					break;
				case "Girl":
					SwfChange("Girl");
					break;
			}
		}
		
		private function SwfChange(str:String) {
			
			//if(loader!=null)
			//{
				//
				//TweenMax.to(loader,.5,{alpha:0,onComplete:function(){
										//loader.unloadAndStop();
										//mainLoader.removeChild(loader);
			switch (str){
				case "Boy" :
					loader = new Loader();
					url = new URLRequest("boy.swf");
					loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onLoadSWF);
					loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,onloadingHandle);
					loader.load(url);
					break;
				case "Girl" :
					loader = new Loader();
					url = new URLRequest("girl.swf");
					loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onLoadSWF);
					loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,onloadingHandle);
					loader.load(url);
					break;
			}
			//}});
			//}
		}
		
		private function onloadingHandle(e:Event):void 
		{
			
		}
		
		private function onLoadSWF(e:Event):void 
		{
			TweenMax.from(loader, .5, { alpha:0 } );
			mainLoader.addChild(loader);
			
			loading.visible = false;
		}
		
		
		private function onBtnClickHandle(e:MouseEvent):void 
		{
			var str:String = e.currentTarget.name;
			switch(str) {
				case "mcBoy":
					stage.dispatchEvent(new Event("Boy"));
					break;
				case "mcGirl":
					stage.dispatchEvent(new Event("Girl"));
					break;	
			}
		}
		private function onUpdateHandle(e:MouseEvent):void 
		{
			
		}
		
		private function onBtnRollHandle(e:MouseEvent):void {
			var str:String = e.type;
			var strName:String = e.currentTarget.name;
			var mc:MovieClip = e.currentTarget as MovieClip;
			switch(str) {
				case "rollOut":
					Mouse.cursor = MouseCursor.ARROW; 
					TweenLite.to(mc, 0.5, {glowFilter:{color:0xffffff, alpha:0, blurX:30, blurY:30}} );
						switch(strName) {
							case "mcBoy":
								
								TweenMax.to(mc.subIcon, 0.3, {alpha:0, scaleX:0.3, scaleY:0.3} );
								TweenLite.to(mcGirl, 0.5, {transformAroundCenter:{scale:1,alpha:1}} );
								break;
							case "mcGirl":
								TweenMax.to(mc.subIcon, 0.3, {alpha:0, scaleX:0.3, scaleY:0.3} );
								TweenLite.to(mcBoy, 0.5, {transformAroundCenter:{scale:1,alpha:1}} );
								break;	
						}
					break;
				case "rollOver":
					TweenLite.to(mc, 0.5, {glowFilter:{color:0xffffff, alpha:1, blurX:30, blurY:30}} );
					Mouse.cursor = MouseCursor.BUTTON;
						switch(strName) {
							case "mcBoy":
								TweenMax.to(mc.subIcon, 1, {alpha:1, scaleX:1, scaleY:1, ease:Elastic.easeOut} );
								TweenLite.to(mcGirl, 0.5, {transformAroundCenter:{scale:0.6,alpha:0.7}} );
								break;
							case "mcGirl":
								TweenMax.to(mc.subIcon, 1, {alpha:1, scaleX:1, scaleY:1, ease:Elastic.easeOut} );
								TweenLite.to(mcBoy, 0.5, {transformAroundCenter:{scale:0.6,alpha:0.7}} );
								break;	
						}
					break;
			}
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
	}
	
}

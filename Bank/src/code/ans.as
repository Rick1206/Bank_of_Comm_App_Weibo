package code {
	
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	import com.greensock.TweenMax;
	import flash.net.URLRequest;
	import flash.net.URLLoader;
	import flash.display.Loader;
	public class ans extends MovieClip {
		private var _loader:Loader;
		
		
		public function ans() {
		
			
		}

		public function loadPic(url:String):void 
		{
			loading.visible = true;
				_loader = new Loader();
				_loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onLoadPicHandle);
				_loader.load(new URLRequest(url));
		}
		public function removePic() {
			if (mainLoader.numChildren > 0) {
				//trace('tt');
				mainLoader.removeChild(mainLoader.getChildAt(0));
			}
		}
		
		private function onLoadPicHandle(e:Event):void 
		{		
			
				loading.visible = false;
				var _bitmap:Bitmap = e.target.content as Bitmap;
					_bitmap.smoothing = true;
					
					
					var _x:Number = _bitmap.width;
					var _y:Number = _bitmap.height;
			
			
					if (mainLoader.numChildren > 0) {
						TweenMax.to(mainLoader, .5, { autoAlpha:0, onComplete:function() { 
							mainLoader.removeChild(mainLoader.getChildAt(0));
							
							
							_bitmap.x = (mcCir.width - _x)/2; 
							_bitmap.y = (mcCir.height - _y)/2;
							mainLoader.addChild(_bitmap);
							mainLoader.alpha = 0;
							TweenMax.to(mainLoader, .5, { autoAlpha:1 } );
							
							}} );
					
					}else {
						
						
				

					_bitmap.x = (mcCir.width - _x)/2; 
					_bitmap.y = (mcCir.height - _y)/2;
					mainLoader.addChild(_bitmap);
					mainLoader.alpha = 0;
					TweenMax.to(mainLoader, .5, { autoAlpha:1 } );
						
						
					}
					

		}
	}
	
}

package code {
	
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.*;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import com.greensock.TweenNano;  


	
	public class index extends MovieClip {
		
		private var _mloader:Loader;
		private var percentage:Number;
		
		
		
		
		public function index() {
			if (stage) {
				init();
			}else {
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
		}
		
		private function init(e:Event=null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			_mloader = new Loader();
			_mloader.contentLoaderInfo.addEventListener(Event.COMPLETE,replaceMe);
			_mloader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,showProgress);
			_mloader.load(new URLRequest("main.swf"));
		}
		private function replaceMe(evt:Event){
			_mloader.content.alpha = 0;
			stage.addChild(_mloader.content);
			stage.removeChild(this);
			TweenNano.to(_mloader.content,0.5,{alpha:1});
			_mloader = null;
		}
		private function showProgress(evt:Event){
			percentage = Math.round(_mloader.contentLoaderInfo.bytesLoaded / _mloader.contentLoaderInfo.bytesTotal * 100);
			perTxt.text = String(percentage)+"%";
			//loading_animation.loadertext.text = String(percentage)+"%";
		}
	}
	
}

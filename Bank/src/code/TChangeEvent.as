package code{
	import flash.events.Event;
	
	public class TChangeEvent extends Event {
		
		public static const TCHO:String = "TCHO";
		public static const TANS:String = "TANS";
		public static const TPER:String = "TPER";
		public static const TWEI:String = "TWEI";
		public static const TNEXT:String = "TNEXT";
		private var _num:String;
		private var _ans:String;
		private var _ansArr:Array;
		private var _weibo:String;
		public function TChangeEvent(eventType:String,bubbles:Boolean = false, cancelable:Boolean = false){
			super(eventType,bubbles,cancelable);
		}
		
		public function get num():String 
		{
			return _num;
		}
		
		public function set num(value:String):void 
		{
			_num = value;
		}
		
		public function get ans():String 
		{
			return _ans;
		}
		
		public function set ans(value:String):void 
		{
			_ans = value;
		}
		
		public function get ansArr():Array 
		{
			return _ansArr;
		}
		
		public function set ansArr(value:Array):void 
		{
			_ansArr = value;
		}
		
		public function get weibo():String 
		{
			return _weibo;
		}
		
		public function set weibo(value:String):void 
		{
			_weibo = value;
		}
	}
}
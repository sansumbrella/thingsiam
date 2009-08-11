package com.thingsiam.events
{
	import flash.events.Event;

	public class ButtonEvent extends Event
	{
		public var id:int;
		public static const CLICK:String = ".ButtonClick";
		
		public function ButtonEvent(type:String, id:int, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			this.id = id;
			super(type, bubbles, cancelable);
		}
		
	}
}
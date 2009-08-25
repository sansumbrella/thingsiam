package com.thingsiam.layout
{
	import flash.events.Event;

	public class LayoutEvent extends Event
	{
		public static const RESIZE:String = "layoutItemResize";
		
		public function LayoutEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			return new LayoutEvent(type, bubbles, cancelable);
		}
	}
}
package com.thingsiam.site.events
{
	import flash.events.Event;

	public class PageEvent extends Event
	{
		public static const REQUEST_CLOSE:String="pageRequestClose";
		
		public function PageEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}
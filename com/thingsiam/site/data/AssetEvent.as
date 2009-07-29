package com.thingsiam.site.data {

import flash.events.Event;

public class AssetEvent extends Event {
	
	public static const FONT_READY:String = "aeFontReady";
	
	public function AssetEvent( type:String, bubbles:Boolean=true, cancelable:Boolean=false )
	{
		super(type, bubbles, cancelable);
	}
	
	override public function clone():Event
	{
		return new AssetEvent(type, bubbles, cancelable);
	}
	
}

}


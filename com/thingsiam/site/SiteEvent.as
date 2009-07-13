package com.thingsiam.site {

import flash.events.Event;

public class SiteEvent extends Event {
	
	/**
	*	Basically just a DataEvent right now
	*	Only with more convenient parameter ordering	
	*	
	*/
	
	public static const PAGE_LOADED:String = "sitePageLoaded";
	public static const PAGE_SHOWN:String = "sitePageShown";
	public static const PAGE_HIDDEN:String = "sitePageHidden";
	public var pageName:String;
	
	public function SiteEvent( type:String, pageName:String, bubbles:Boolean=true, cancelable:Boolean=false )
	{
		super(type, bubbles, cancelable);
		this.pageName = pageName;
	}
	
	override public function clone():Event
	{
		return new SiteEvent(type, info, bubbles, cancelable);
	}
	
}

}


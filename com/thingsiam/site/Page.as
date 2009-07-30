package com.thingsiam.site {

import flash.display.Sprite;
import flash.events.Event;

public class Page extends Sprite {
	
	protected var _url:String;	//the address of the page
	
	public function Page()
	{
		super();
	}
	
	public function show():void
	{
		handleShown();
	}
	
	public function hide():void
	{
		handleHidden();
	}
	
	protected function handleShown():void
	{
		dispatchEvent( new Event( SiteEvent.PAGE_SHOWN ));
	}
	
	protected function handleHidden():void
	{
		dispatchEvent( new Event( SiteEvent.PAGE_HIDDEN ));
	}
	
	public function get url():String{
		return _url;
	}
	
	public function set url(value:String):void {
		_url = value;
	}
}

}


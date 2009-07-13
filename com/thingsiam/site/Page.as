package com.thingsiam.site {

import flash.display.Sprite;
import flash.events.Event;

public class Page extends Sprite {
	
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
	
}

}


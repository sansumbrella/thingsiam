package com.thingsiam.site {

import flash.display.Sprite;
import flash.events.Event;
import com.thingsiam.site.events.SiteEvent;

public class PageState extends Sprite {
	
	/**
	*	A showable/hidable sprite that lets the world know when it's transitions are complete	
	*	
	*/
	
	public function PageState()
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


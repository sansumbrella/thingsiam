package com.thingsiam.site {

import flash.display.Sprite;
import flash.geom.Rectangle;
import flash.events.Event;

import com.thingsiam.site.events.SiteEvent;

public class PageState extends Sprite {
	
	/**
	*	A showable/hidable sprite that lets the world know when it's transitions are complete	
	*	
	*/
	protected var _hidden:Boolean = true;
	
	public function PageState()
	{
		super();
	}
	
	public final function show():void
	{
		_hidden = false;
		playShowTransition();
	}
	
	public final function hide():void
	{
		if(_hidden)
		{
			handleHidden();
		} else
		{
			playHideTransition();
		}
	}
	
	protected function playShowTransition():void
	{
		handleShown();
	}
	
	protected function playHideTransition():void
	{	//do what you want in here
		handleHidden();
	}
	
	public function setState(state:String, force:Boolean=false):void
	{
		
	}
	
	public function resize( rect:Rectangle ):void
	{
		
	}
	
	protected function handleShown(e:Event=null):void
	{
		dispatchEvent( new Event( SiteEvent.PAGE_SHOWN ));
	}
	
	protected function handleHidden(e:Event=null):void
	{
		_hidden = true;
		dispatchEvent( new Event( SiteEvent.PAGE_HIDDEN ));
	}
}

}


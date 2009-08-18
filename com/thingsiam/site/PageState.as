package com.thingsiam.site {

import com.thingsiam.site.events.SiteEvent;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.geom.Rectangle;

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
		if(_hidden == true)
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
		if( e != null )
		{
			(e.target as EventDispatcher).removeEventListener(SiteEvent.PAGE_SHOWN, handleShown);
		}
		dispatchEvent( new Event( SiteEvent.PAGE_SHOWN ));
	}
	
	protected function handleHidden(e:Event=null):void
	{
		_hidden = true;
		if( e != null )
		{
			(e.target as EventDispatcher).removeEventListener(SiteEvent.PAGE_HIDDEN, handleHidden);
		}
		dispatchEvent( new Event( SiteEvent.PAGE_HIDDEN ));
	}
}

}


package com.thingsiam.site {

import com.thingsiam.site.events.SiteEvent;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.geom.Rectangle;

import gs.TweenLite;
import gs.easing.Quad;

public class PageState extends Sprite {
	
	/**
	*	A showable/hidable sprite that lets the world know when it's transitions are complete	
	*	
	*/
	protected var _hidden:Boolean = true;
	private var _animating:Boolean = false;
	
	public function PageState()
	{
		super();
	}
	
	public final function show():void
	{
		_hidden = false;
		_animating = true;
		playShowTransition();
	}
	
	public final function hide():void
	{
		_animating = true;
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
		alpha = 0;
		new TweenLite( this, 1.25, { alpha:1, onComplete:handleShown, ease:Quad.easeInOut } );
	}
	
	protected function playHideTransition():void
	{	//do what you want in here
		new TweenLite( this, 0.6, { alpha:0, onComplete:handleHidden, ease:Quad.easeIn } );
	}
	
	public function setState(state:String, force:Boolean=false):void
	{
		
	}
	
	public function resize( rect:Rectangle ):void
	{
		
	}
	
	protected final function handleShown(e:Event=null):void
	{
		_animating = false;
		if( e != null )
		{
			(e.target as EventDispatcher).removeEventListener(SiteEvent.PAGE_SHOWN, handleShown);
		}
		dispatchEvent( new Event( SiteEvent.PAGE_SHOWN ));
	}
	
	protected final function handleHidden(e:Event=null):void
	{
		_hidden = true;
		_animating = false;
		if( e != null )
		{
			(e.target as EventDispatcher).removeEventListener(SiteEvent.PAGE_HIDDEN, handleHidden);
		}
		dispatchEvent( new Event( SiteEvent.PAGE_HIDDEN ));
	}
	
	public function get animating():Boolean
	{
		return _animating;
	}
}

}


package com.thingsiam.site {

import com.thingsiam.layout.ScreenModel;
import com.thingsiam.site.events.SiteEvent;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.EventDispatcher;

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
		ScreenModel.instance.addEventListener(Event.CHANGE, handleResize);
		updateLayout();
		playShowTransition();
	}
	
	public final function hide():void
	{
		ScreenModel.instance.removeEventListener(Event.CHANGE, handleResize);
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
	{	//override to do whatever, call handleShown when you're done
		alpha = 0;
		new TweenLite( this, 1.25, { alpha:1, onComplete:handleShown, ease:Quad.easeInOut } );
	}
	
	protected function playHideTransition():void
	{	//do what you want in here, call handleHidden when you're done
		new TweenLite( this, 0.6, { alpha:0, onComplete:handleHidden, ease:Quad.easeIn } );
	}
	
	public function setState(state:String, force:Boolean=false):void
	{
		
	}
	
	protected function handleResize( e:Event ):void
	{
		updateLayout();
	}
	
	public function updateLayout():void
	{	//does nothing by default, do what you want
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


package com.thingsiam.site {

import flash.display.Sprite;
import flash.events.Event;
import com.thingsiam.site.model.PageModel;
import com.thingsiam.site.PageSection;
import flash.utils.Dictionary;

public class Page extends Sprite {
	
	/*
		Controller
		Handles turning its display state to match the model
	*/
	
	protected var 	_url:String;	//the address of the page
	protected var 	_model:PageModel;
	protected var 	_currentState:PageSection,
					_nextState:PageSection,
					_possibleStates:Dictionary;
	
	public function Page()
	{
		super();
	}
	
	/*
		Navigation functions
	*/
	
	public function setState( name:String ):void
	{	//allows the outside site to tell us where to go (necessary for SWFAddress compatibility)
		if( !_model )
		{
			throw new Error("Page _model is not yet defined. Make sure to initialize it in the subclass.");
		}
		_model.setState(name);
	}
	
	protected function updateView( e:Event ):void
	{
		
	}
	
	protected function setModel( model:PageModel ):void
	{
		_model = model;
		_model.addEventListener( Event.CHANGE, updateView, false, 0, true );
	}
	
	/*
		Basic Display Functions
	*/
	
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
	
	/*
		
	*/
	
	public function get url():String{
		return _url;
	}
	
	public function set url(value:String):void {
		_url = value;
	}
}

}


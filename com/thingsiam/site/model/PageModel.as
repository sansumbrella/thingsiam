package com.thingsiam.site.model {

import flash.events.EventDispatcher;
import flash.events.Event;

public class PageModel extends EventDispatcher {
	
	protected var 	_states		:Array;
	protected var 	_currentState		:String,
					_currentSection		:String, //first component of state
					_fragments			:Array;
	
	public function PageModel()
	{
		super();
		_states = new Array();
		_fragments = new Array();
	}
	
	public function setState(state:String):void
	{
		if( _currentState == state )
		{
			return;
		}
		//add a 404 check
		_currentState = state;
		_fragments = _currentState.split("/");
		_currentSection = _fragments[0];
		dispatchEvent( new Event(Event.CHANGE) );
	}
	
	public function get state():String{
		return _currentState;
	}
	
	public function get section():String{
		return _currentSection;
	}
	
}

}
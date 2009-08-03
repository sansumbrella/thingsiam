package com.thingsiam.site.model {

import flash.events.EventDispatcher;
import flash.events.Event;

public class PageModel extends EventDispatcher {
	
	protected var 	_states				:Array;
	protected var 	_currentState		:String,
					_currentSection		:String, //first component of state
					_fragments			:Array;
	public static const INDEX:String = "index";								
	
	public function PageModel()
	{
		super();
		_states = new Array( INDEX );
		_fragments = new Array();
	}
	
	public function setState(state:String):void
	{
		if( _currentState == state )
		{	//don't reload the current state
			return;
		}
		if( _states.indexOf(state.split("/")[0]) == -1 )
		{	//don't attempt to load unknown states
			return;
		}
		
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
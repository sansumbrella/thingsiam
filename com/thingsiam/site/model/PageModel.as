package com.thingsiam.site.model {

import flash.events.Event;
import flash.events.EventDispatcher;

public class PageModel extends EventDispatcher {
	
	protected var 	_states				:Array;
	protected var 	_currentState		:String;
	protected var	_fragments			:Array;
	public static const INDEX:String = "index";								
	
	public function PageModel()
	{
		super();
		_states = new Array( INDEX );
		_fragments = new Array();
	}
	
	public function setState(state:String, force:Boolean=false):void
	{
		if( _currentState == state && !force )
		{	//don't reload the current state
			return;
		}
		if( _states.indexOf(state.split("/")[0]) == -1  && !force )
		{	//don't attempt to load unknown states
			return;
		}
		
		_currentState = state;
		_fragments = _currentState.split("/");
		_currentSection = _fragments[0];
		_currentSubsection = "";
		if( _fragments.length > 1 )
		{
			for( var i:int=1; i!=_fragments.length; i++ )
			{
				_currentSubsection += _fragments[i] + "/";
			}
		}
		dispatchEvent( new Event(Event.CHANGE) );
	}
	
	//
	//	Accessors
	//
	
	public function get state():String{
		return _currentState;
	}
	
	public function get section():String{
		return _currentSection;
	}
	
	
	// use fragments in controller to pass on fragmentsAfter the current section to child models 
	
	public function getFragment(index:int):String
	{
		return _fragments[index];
	}
	
	public function getFragmentsAfterIndex(index:int):String
	{
		if( _fragments.length <= index )
		{
			return "";	
		}
		return _fragments.slice(index+1).join("/");
	}
	
	public function getFragmentsAfter(fragment:String):String
	{
		return getFragmentsAfterIndex(_fragments.indexOf(fragment));
	}
	
	public function get numFragments():int
	{
		return _fragments.length;
	}
	
}

}
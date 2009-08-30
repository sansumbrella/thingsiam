package com.thingsiam.site.model {

import flash.events.Event;
import flash.events.EventDispatcher;

public class PageModel extends EventDispatcher {
	
	protected var 	_states				:Array;
	protected var 	_currentState		:String;
	protected var	_fragments			:Array;
	protected var	_baseChange			:Boolean=true;	//whether the root section changed, or just extra bits
	public static const INDEX:String = "";								
	
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
		
		var base:String = _fragments[0];
		_currentState = state;
		_fragments = _currentState.split("/");
		
		_baseChange = (_fragments[0] == base) ? false : true;
		trace("PageModel State Changed", _baseChange, base, _fragments[0] );
		dispatchEvent( new Event(Event.CHANGE) );
	}
	
	//
	//	Accessors
	//
	
	public function get state():String{
		return _currentState;
	}
	
	// use fragments in controller to pass on fragmentsAfter the current section to child models 
	
	public function getFragment(index:int):String
	{
		if( _fragments.length > index )
			return _fragments[index];
		return "";
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
	
	public function get baseChange():Boolean{
		return _baseChange;
	}
	
}

}
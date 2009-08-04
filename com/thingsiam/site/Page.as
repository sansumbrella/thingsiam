package com.thingsiam.site {

import flash.display.Sprite;
import flash.events.Event;

import com.thingsiam.site.events.SiteEvent;
import com.thingsiam.site.model.PageModel;
import com.thingsiam.site.PageState;
import flash.utils.Dictionary;

public class Page extends PageState {
	
	/*
		Controller
		Handles turning its display state to match the model
		Doesn't need to load states, since they're baked in (unlike for AbstractSite)
	*/
	protected var 	_stateDepth:int = 0;
	protected var 	_url:String;	//the address of the page
	protected var 	_model:PageModel;
	protected var 	_currentState:PageState,
					_nextState:PageState,
					_possibleStates:Dictionary;
	
	public function Page()
	{
		super();
		init();
	}
	
	private function init():void
	{
		_possibleStates = new Dictionary;
	}
	
	/*
		Navigation functions
	*/
	
	override public function setState( name:String, force:Boolean=false ):void
	{	//allows the outside site to tell us where to go (necessary for SWFAddress compatibility)
		if( !_model )
		{
			throw new Error("Page _model is not yet defined. Make sure to initialize it in the subclass.");
		}
		_model.setState(name, force);
	}
	
	protected function updateView( e:Event ):void
	{
		_nextState = _possibleStates[_model.section];
		transitionToState();
	}
	
	protected function transitionToState():void
	{
		if( _currentState != null && _currentState != _nextState )
		{	//transition out, and transition in afterwards
			_currentState.addEventListener( SiteEvent.PAGE_HIDDEN, displayNextState, false, 0, true );
			_currentState.hide();
		} else
		{	//just transition in
			displayNextState();
		}
	}
	
	protected function displayNextState(e:Event=null):void
	{
		if( _currentState != null )
		{	//get rid of the current page
			_currentState.removeEventListener( SiteEvent.PAGE_HIDDEN, displayNextState );
			if(contains(_currentState))
			{
				removeChild( _currentState );
			}
		}
		//swap over to the next page
		_currentState = _nextState;
		addChildAt( _currentState, _stateDepth );
		_currentState.addEventListener( SiteEvent.PAGE_SHOWN, handleStateShown, false, 0, true );
		_currentState.setState(_model.subsection);
		_currentState.show();
	}
	
	protected function handleStateShown(e:Event):void
	{
		
	}
	
	protected function setModel( model:PageModel ):void
	{
		if( _model )
		{
			_model.removeEventListener( Event.CHANGE, updateView );
		}
		_model = model;
		_model.addEventListener( Event.CHANGE, updateView, false, 0, true );
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


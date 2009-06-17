package com.thingsiam.functions {

import flash.utils.Dictionary;

public class ConditionalCaller extends Object {
	
	/**
	*	@author David Wicks
	*	Helps with executing functions only after certain conditions are met
	*	Say: after one element loads, but also after the user clicks on something
	*	This class helps to clean up main class code by encapsulating the logic of whether requirements are met
	*	It calls the function passed in after all the requirements are satisfied
	*	
	*	This solution is somewhat problematic because it doesn't lock down the function to be called after conditions are met
	*	To prevent that, a call to meetsAllRequirements could be added to the passed-in _function body,
	*	but that would slow us down both in writing and executing code
	*/
	
	private static const PASSED:int=1, REQUIRED:int=0;
	private var _requirements:Dictionary;
	private var _function:Function;
	
	public function ConditionalCaller( f:Function )
	{
		super();
		_requirements = new Dictionary();
		_function = f;
	}
	
	public function meetRequirement( requirement:Object ):void
	{
		_requirements[requirement] = PASSED;
		if( meetsAllRequirements() )
		{
			_function();
		}
	}
	
	public function meetsAllRequirements():Boolean
	{
		for each( var r:int in _requirements )
		{
			if( r == REQUIRED )
				return false;
		}
		return true;
	}
	
	public function addRequirement( requirement:Object ):void
	{
		_requirements[requirement] = REQUIRED;
	}
	
	public function reset():void
	{
		for ( var r:Object in _requirements )
		{
			_requirements[r] = REQUIRED;
		}
	}
	
	public function removeRequirement( requirement:Object ):void
	{
		delete _requirements[requirement];
	}
	
}

}


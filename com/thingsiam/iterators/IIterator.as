package com.thingsiam.iterators {
	
	/*
	*	@author David Wicks
	*	@since  08.05.2008
	*/
	public interface IIterator {
		function reset():void;
		function current():Object;
		function next():Object;
		function hasNext():Boolean;
	}
	
}

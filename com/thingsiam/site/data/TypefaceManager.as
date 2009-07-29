package com.thingsiam.site.data {

import flash.events.EventDispatcher;
import flash.utils.Dictionary;

public class TypefaceManager extends EventDispatcher {
	
	private var _instance:TypefaceManager;
	private var _typefaces:Dictionary;
	
	public function TypefaceManager( Lock l )
	{
		super();
	}
	
	public function get instance():TypefaceManager{
		if( !_instance ) _instance = new TypefaceManager(new Lock);
		return _instance;
	}
	
	
}

}

class Lock{}
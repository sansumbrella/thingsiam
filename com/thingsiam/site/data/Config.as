package com.thingsiam.site.data {

import flash.event.Event;
import flash.event.EventDispatcher;
import flash.net.URLRequest;
import flash.net.URLLoader;

public class Config extends EventDispatcher {
	
	// Loads in config.xml, reports when that's ready
	// Globally accessible, duh
	
	private static var _instance:Config;
	
	public function Config( Lock l )
	{
		super();
	}
	
	public static function get instance():Config{
		if(!_instance) _instance = new Config(new Lock());
		return _instance;
	}
	
	public function load(path:String="xml/config.xml"):void
	{
		
	}
	
}

}

class Lock{}
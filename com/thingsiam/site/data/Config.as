package com.thingsiam.site.data {

import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IOErrorEvent;
import flash.net.URLLoader;
import flash.net.URLRequest;
import flash.xml.*;

public class Config extends EventDispatcher {
	
	// Loads in config.xml, reports when that's ready
	// Globally accessible, duh
	
	private static var _instance:Config;
	private var _xml:XML;
	
	public function Config( l:Lock )
	{
		super();
	}
	
	public static function get instance():Config{
		if(!_instance) _instance = new Config(new Lock());
		return _instance;
	}
	
	public function load(path:String="xml/config.xml"):void
	{
		var loader:URLLoader = new URLLoader();
		loader.addEventListener(Event.COMPLETE, handleLoad );
		loader.addEventListener(IOErrorEvent.IO_ERROR, handleError);
		loader.load(new URLRequest(path));
	}
	
	private function handleLoad(e:Event):void
	{
		(e.target as URLLoader).removeEventListener(Event.COMPLETE, handleLoad);
		(e.target as URLLoader).removeEventListener(IOErrorEvent.IO_ERROR, handleError);
		
		//grab the data and tell the world
		_xml = XML((e.target as URLLoader).data);
		dispatchEvent(new Event(Event.COMPLETE) );
	}
	
	private function handleError(e:IOErrorEvent):void
	{
		(e.target as URLLoader).removeEventListener(Event.COMPLETE, handleLoad);
		(e.target as URLLoader).removeEventListener(IOErrorEvent.IO_ERROR, handleError);
	}
	
	public function getBasePath():String
	{
		return "";	
	}
	
	public function get xml():XML
	{
		return _xml;
	}
}

}

class Lock{}
package com.thingsiam.site {

import flash.utils.Dictionary;
import flash.events.EventDispatcher;
import flash.events.Event;
import flash.events.ProgressEvent;
import flash.events.IOErrorEvent;

import com.thingsiam.site.data.PageRequest;
import com.thingsiam.site.events.SiteEvent;

public class PageCache extends EventDispatcher {
	
	/**
	*	Stores pages in a cache
	*	pages can be retrieved, reloaded, purged
	*	
	*	Singleton, since it would be silly to have multiple caches storing the same things
	*/
	
	private var _pages:Dictionary;
	private var _basePath:String = "";
	private static var _instance:PageCache;
	
	public function PageCache( enforcer:SingletonEnforcer )
	{
		super();
		init();
	}
	
	public static function get instance():PageCache{
		if( !_instance ) _instance = new PageCache(new SingletonEnforcer());
		return _instance;
	}
	
	private function init():void
	{
		_pages = new Dictionary;
	}
	
	public function retrieve( pageName:String ):Page
	{
		if( _pages[pageName] )
		{
			return _pages[pageName];
		}
		
		loadPage( pageName );
		return null;
	}
	
	// Handle loading of missing pages
	
	private function loadPage( pageName:String ):void
	{
		var loader:PageRequest = new PageRequest( pageName, _basePath );
		loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, handleProgress, false, 0, true);
		loader.contentLoaderInfo.addEventListener(Event.COMPLETE, handleLoad, false, 0, true);
		loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, handleError, false, 0, true);
		loader.loadPage();
	}
	
	// image loading events
	private function handleLoad(e:Event):void {
		e.target.removeEventListener( Event.COMPLETE, handleLoad );
		e.target.removeEventListener( ProgressEvent.PROGRESS, handleProgress );
		e.target.removeEventListener(IOErrorEvent.IO_ERROR, handleError );
		
		var pageName:String = e.target.loader.pageName;
		
		_pages[pageName] = e.target.content as Page;
		_pages[pageName].url = pageName;
		
		dispatchEvent( e );
		dispatchEvent( new SiteEvent( SiteEvent.PAGE_LOADED, pageName ) );
	}

	private function handleProgress( e:ProgressEvent ):void {
		//just pass along the event for preloaders
		dispatchEvent( e );
	}
	
	private function handleError(e:IOErrorEvent):void
	{
		trace("PageCache::handleError()",  e);
	}
	
	public function set basePath(value:String):void {
		_basePath = value;
	}
	
	public function get basePath():String{
		return _basePath;
	}
	
}

}

class SingletonEnforcer{}


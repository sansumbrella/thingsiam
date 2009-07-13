package com.thingsiam.site {

import flash.utils.Dictionary;
import flash.display.Loader;
import flash.events.EventDispatcher;

public class PageCache extends EventDispatcher {
	
	/**
	*	Stores pages in a cache
	*	pages can be retrieved, reloaded, purged
	*	
	*	Singleton, since it would be silly to have multiple caches storing the same things
	*/
	
	private var _pages:Dictionary;
	
	public function PageCache( enforcer:SingletonEnforcer )
	{
		super();
		init();
	}
	
	public function get instance():PageCace{
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
		var loader:Loader = new Loader();
		loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, handleProgress, false, 0, true);
		loader.contentLoaderInfo.addEventListener(Event.COMPLETE, handleLoad, false, 0, true);
		loader.load(new URLRequest(url));
	}
	
	// image loading events
	function handleLoad(e:Event):void {
		e.target.removeEventListener( Event.COMPLETE, handleLoad );
		e.target.removeEventListener( ProgressEvent.PROGRESS, handleProgress );
		
		//store the page in the cache
		var pageName:String = loader.contentLoaderInfo.url;
		_pages[pageName] = e.target.content as Page;
		
		dispatchEvent( e );
		dispatchEvent( new SiteEvent( SiteEvent.PAGE_LOADED, pageName ) );
	}

	function handleProgress( e:ProgressEvent ):void {
		//just pass along the event for preloaders
		dispatchEvent( e );
	}
	
}

}

class SingletonEnforcer{}


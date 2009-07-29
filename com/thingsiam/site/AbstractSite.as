package com.thingsiam.site {

import flash.display.Sprite;
import com.thingsiam.loading.BasicPreloader;
import flash.events.Event;

public class AbstractSite extends Sprite {
	
	protected var	_currentPage:Page,
					_nextPage:Page;
	
	protected var _preloader:BasicPreloader;
	
	public function AbstractSite()
	{
		super();
	}
	
	public function loadPage( name:String ):void
	{
		_nextPage = PageCache.instance.retrieve( name );
		if( _nextPage )
		{
			transitionToPage();
		} else
		{
			PageCache.instance.addEventListener( SiteEvent.PAGE_LOADED, transitionToPage );
			_preloader.observe( PageCache.instance );
		}
		
		disableNavigation();
	}
	
	protected function disableNavigation():void
	{
		
	}
	
	protected function enableNavigation():void
	{
		
	}
	
	private function transitionToPage( e:SiteEvent = null ):void
	{
		if( e != null )
		{	//we just completed loading the page
			PageCache.instance.removeEventListener( SiteEvent.PAGE_LOADED, transitionToPage );
			_nextPage = PageCache.instance.retrieve( e.pageName );
		}
		
		if( _currentPage != null )
		{	//transition out, and transition in afterwards
			_currentPage.addEventListener( SiteEvent.PAGE_HIDDEN, displayNextPage );
			_currentPage.hide();
		} else
		{	//just transition in
			displayNextPage();
		}
	}
	
	private function displayNextPage(e:Event = null):void
	{	//swap over to the next page
		
		if( _currentPage && contains(_currentPage) )
		{
			removeChild( _currentPage );
		}
		
		_currentPage = _nextPage;
		addChild( _currentPage );
		_currentPage.show();
		
		enableNavigation();
	}
	
}

}


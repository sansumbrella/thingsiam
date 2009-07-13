package com.thingsiam.site {

import flash.display.Sprite;
import com.thingsiam.loading.BasicPreloader;

public class AbstractSite extends Sprite {
	
	private var _currentPage:Page,
				_nextPage:Page;
	
	private var _preloader:BasicPreloader;
	
	public function AbstractSite()
	{
		super();
	}
	
	public function loadPage( name:String ):void
	{
		if( _nextPage = PageCache.instance.retrieve( name ) )
		{
			transitionToPage( _nextPage );
		} else
		{
			PageCache.instance.addEventListener( SiteEvent.PAGE_LOADED, transitionToPage );
			_preloader.observe( PageCache );
		}
	}
	
	private function transitionToPage( e:SiteEvent = null ):void
	{
		if( e != null )
		{	//we just completed loading the page
			PageCache.instance.removeEventListener( SiteEvent.PAGE_LOADED, transitionToPage );
			_nextPage = PageCache.instance.retrieve( e.pageName );
		}
		
		if( _currentPage )
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
		removeChild( _currentPage );
		
		_currentPage = _nextPage;
		addChild( _currentPage );
		_currentPage.show();
	}
	
}

}


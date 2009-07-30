package com.thingsiam.site {

import flash.display.Sprite;
import com.thingsiam.loading.BasicPreloader;
import flash.events.Event;
import com.thingsiam.layout.ScreenModel;

public class AbstractSite extends Sprite {
	
	protected var	_currentPage:Page,
					_nextPage:Page;
	
	protected var _preloader:BasicPreloader;
	protected var _screen:ScreenModel;
	
	public function AbstractSite()
	{
		super();
		init();
	}
	
	private function init():void
	{
		_screen = new ScreenModel(this.stage);
		_preloader = new BasicPreloader();
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
		
		dispatchEvent( new SiteEvent(SiteEvent.TRANSITION_BEGIN, name) );
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
			_currentPage.addEventListener( SiteEvent.PAGE_HIDDEN, displayNextPage, false, 0, true );
			_currentPage.hide();
		} else
		{	//just transition in
			displayNextPage();
		}
	}
	
	private function displayNextPage(e:Event = null):void
	{	//swap over to the next page
		
		if( _currentPage != null )
		{
			_currentPage.removeEventListener( SiteEvent.PAGE_HIDDEN, displayNextPage );
			if(contains(_currentPage))
			{
				removeChild( _currentPage );
			}
		}
		
		_currentPage = _nextPage;
		addChild( _currentPage );
		_currentPage.addEventListener( SiteEvent.PAGE_SHOWN, handlePageShown, false, 0, true );
		_currentPage.show();
	}
	
	private function handlePageShown(e:Event):void
	{
		_currentPage.removeEventListener( SiteEvent.PAGE_SHOWN, handlePageShown );
		dispatchEvent( new SiteEvent(SiteEvent.TRANSITION_END, _currentPage.url ));
	}
}

}


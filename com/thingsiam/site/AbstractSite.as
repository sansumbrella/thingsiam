package com.thingsiam.site {

import flash.display.Sprite;
import flash.events.Event;

import com.thingsiam.loading.BasicPreloader;
import com.thingsiam.layout.ScreenModel;
import com.thingsiam.site.model.SiteModel;
import com.thingsiam.site.controllers.NavigationController;

public class AbstractSite extends Sprite {
	
	protected var	_currentPage:Page,
					_nextPage:Page,
					_requestedSection:String;
	
	protected var _navigation:NavigationController;
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
		model.addEventListener( Event.CHANGE, handleModelChange );
	}
	
	protected function handleModelChange(e:Event):void
	{	//jump straight to where we're going
		navigateTo( model.page, model.section );
	}
	
	public function navigateTo( page:String, section:String="" ):void
	{
		if( page != SiteModel.PAGE_404 )
		{			
			_nextPage = PageCache.instance.retrieve( page );
			_requestedSection = section;
			if( _nextPage )
			{
				transitionToPage();
			} else
			{
				PageCache.instance.addEventListener( SiteEvent.PAGE_LOADED, transitionToPage );
				_preloader.observe( PageCache.instance );
			}
		
			dispatchEvent( new SiteEvent(SiteEvent.TRANSITION_BEGIN, page) );
		} else 
		{	//if you want to handle the 404, listen for this event
			dispatchEvent( new SiteEvent(SiteEvent.PAGE_NOT_FOUND, page ));
		}
	}
	
	private function transitionToPage( e:SiteEvent = null ):void
	{
		if( e != null )
		{	//we just completed loading the page
			PageCache.instance.removeEventListener( SiteEvent.PAGE_LOADED, transitionToPage );
			_nextPage = PageCache.instance.retrieve( e.pageName );
		}
		
		if( _currentPage != null && _currentPage != _nextPage )
		{	//transition out, and transition in afterwards
			_currentPage.addEventListener( SiteEvent.PAGE_HIDDEN, displayNextPage, false, 0, true );
			_currentPage.hide();
		} else
		{	//just transition in
			displayNextPage();
		}
	}
	
	private function displayNextPage(e:Event = null):void
	{
		if( _currentPage != _nextPage )
		{	
			if( _currentPage != null )
			{	//get rid of the current page
				_currentPage.removeEventListener( SiteEvent.PAGE_HIDDEN, displayNextPage );
				if(contains(_currentPage))
				{
					removeChild( _currentPage );
				}
			}
			//swap over to the next page
			_currentPage = _nextPage;
			addChild( _currentPage );
			_currentPage.addEventListener( SiteEvent.PAGE_SHOWN, handlePageShown, false, 0, true );
			_currentPage.show();
		} else
		{	//we're already on the page, go to the correct section
			_currentPage.displaySection(_requestedSection);
		}
	}
	
	private function handlePageShown(e:Event):void
	{
		//It's there, now just go to the right part
		_currentPage.removeEventListener( SiteEvent.PAGE_SHOWN, handlePageShown );
		_currentPage.displaySection(_requestedSection);
		dispatchEvent( new SiteEvent(SiteEvent.TRANSITION_END, _currentPage.url ));
	}
	
	/*
		Convenience Functions
	*/
	
	public function get model():SiteModel{
		return SiteModel.instance;
	}
}

}


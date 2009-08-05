package com.thingsiam.site {

import flash.display.Sprite;
import flash.events.Event;

import com.thingsiam.loading.BasicPreloader;
import com.thingsiam.layout.ScreenModel;

import com.thingsiam.site.events.SiteEvent;
import com.thingsiam.site.model.SiteModel;
import com.thingsiam.site.controllers.NavigationController;

public class AbstractSite extends Sprite {
	
	protected var	_currentPage:Page,
					_nextPage:Page,
					_requestedSection:String;
	
	protected var _navigation:NavigationController;
	protected var _preloader:BasicPreloader;
	protected var _screen:ScreenModel;
	protected var _pageDepth:int = 0;
	private var _ready	:Boolean = true;
	
	public function AbstractSite()
	{
		super();
		init();
	}
	
	private function init():void
	{
		_screen = new ScreenModel(this.stage, 1024, 768);
		_preloader = new BasicPreloader();
		model.addEventListener( Event.CHANGE, handleModelChange );
	}
	
	protected function ignoreModel():void
	{
		model.removeEventListener( Event.CHANGE, handleModelChange );
	}
	
	protected function observeModel():void
	{
		model.addEventListener( Event.CHANGE, handleModelChange );
	}
	
	protected function handleModelChange(e:Event):void
	{	//get to where we're going
		navigateTo( model.page, model.section );
	}
	
	protected function navigateTo( page:String, section:String="" ):void
	{
		if(_ready)
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
					addChild(_preloader.view);
				}
			} else 
			{	//if you want to handle the 404, listen for this event
				dispatchEvent( new SiteEvent(SiteEvent.PAGE_NOT_FOUND, page ));
			}
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
			addChildAt( _currentPage, _pageDepth );
			_currentPage.addEventListener( SiteEvent.PAGE_SHOWN, handlePageShown, false, 0, true );
			_currentPage.show();
		} else
		{	//we're already on the page, go to the correct section
			_currentPage.setState(_requestedSection);
		}
		dispatchEvent( new SiteEvent(SiteEvent.TRANSITION_BEGIN, _currentPage.url) );
	}
	
	private function handlePageShown(e:Event):void
	{
		//It's there, now just go to the right part
		_currentPage.removeEventListener( SiteEvent.PAGE_SHOWN, handlePageShown );
		_currentPage.setState(_requestedSection);
		dispatchEvent( new SiteEvent(SiteEvent.TRANSITION_END, _currentPage.url ));
	}
	
	/*
		Convenience Functions
	*/
	
	protected function get model():SiteModel{
		return SiteModel.instance;
	}
	
	protected function get ready():Boolean{
		return _ready;
	}
	
	protected function set ready(value:Boolean):void {
		_ready = value;
		if( _ready )
		{
			navigateTo(model.page, model.section);
		}
	}
}

}


package com.thingsiam.layout {

import flash.display.Sprite;
import flash.display.DisplayObject;
import flash.events.Event;

public class Paginator extends Sprite {
	
	private var _pages:Array;	//contains only LayoutArray objects
	private var _currentPage:LayoutArray;
	private var _layoutType:Class;
	private var _itemsPerPage:int;
	
	public function Paginator( layoutType:Class, itemsPerPage:int=5 )
	{
		super();
		_layoutType = layoutType;
		_itemsPerPage = itemsPerPage;
		init();
	}
	
	private function init():void
	{
		_pages = new Array();
		addPage();
		requestPage(0);
	}
	
	public function requestPage( id:int ):void
	{	//pages are zero-indexed, just like an array
		if( _pages[id] == _currentPage )
		{
			return;
		}
		setPage(id);
		
	}
	
	private function setPage(id:int):void
	{
		if( _currentPage && contains(_currentPage) ) removeChild(_currentPage);
		_currentPage = _pages[id];
		addChild(_currentPage);
	}
	
	public function push( item:DisplayObject ):void
	{
		if( ! _pages[_pages.length-1].push(item) )
		{
			addPage();
			push(item);
		}
	}
	
	private function addPage():void
	{
		_pages.push( new _layoutType() )
		_pages[_pages.length-1].maxElements = _itemsPerPage;
		dispatchEvent( new Event(Event.CHANGE) );	//announce change in size
	}
	
	public function dump():void
	{
		if( _currentPage && contains(_currentPage)) removeChild(_currentPage);
		_pages = new Array();
		addPage();
		requestPage(0);
	}
	
	public function get pageCount():int{
		return _pages.length;
	}
	
}

}


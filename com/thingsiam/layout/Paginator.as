package com.thingsiam.layout {

import flash.display.Sprite;
import flash.display.DisplayObject;
import flash.events.Event;

import com.thingsiam.iterators.*;

public class Paginator extends Sprite {
	
	private var _pages:Array;	//contains only LayoutArray objects
	private var _currentPage:LayoutArray;
	private var _currentIndex:int=0;
	private var _layoutType:Class;
	private var _itemsPerPage:int;
	private var _wrapEnd:Boolean = true;
	
	public static const RESIZE:String="resize";
	public static const TURN:String="pageTurn";
	
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
	
	//
	//	Traversal
	//
	
	public function requestPage( id:int ):void
	{	//pages are zero-indexed, just like an array
		if( _pages[id] == _currentPage )
		{	//already there
			return;
		}		
		setPage(id);
	}
	
	public function next():void
	{
		requestPage(_currentIndex+1);
	}
	
	public function previous():void
	{
		requestPage(_currentIndex-1);
	}
	
	private function setPage(id:int):void
	{
		id = constrainPageID(id);
		if( _currentPage && contains(_currentPage) ) removeChild(_currentPage);
		_currentPage = _pages[id];
		addChild(_currentPage);
		_currentIndex = id;
		//handle this event to animate the page change
		dispatchEvent( new Event(TURN) );
	}
	
	private function constrainPageID(id:int):int
	{	//make sure it's a valid page, either by wrapping or clamping
		if( id >= _pages.length )
		{
			if( _wrapEnd )
				id = 0;
			else
				id = _pages.length-1;
		} else if(id < 0)
		{
			if(_wrapEnd)
				id = _pages.length-1;
			else
				id = 0;
		}
		return id;
	}
	
	//
	//
	//
	
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
		dispatchEvent( new Event(RESIZE) );	//announce change in size
	}
	
	public function dump():void
	{
		if( _currentPage && contains(_currentPage)) removeChild(_currentPage);
		_pages = new Array();
		addPage();
		requestPage(0);
		dispatchEvent( new Event(RESIZE) );
	}
	
	public function get pageCount():int{
		return _pages.length;
	}
	
	public function get currentIndex():int{
		return _currentIndex;
	}
	
	public function get wrapEnd():Boolean{
		return _wrapEnd;
	}
	
	public function set wrapEnd(value:Boolean):void {
		_wrapEnd = value;
	}
	
	//
	//	Layout function wrappers
	//
	
	public function forEachWithIndex(fn:Function):void
	{
		_currentPage.forEachWithIndex(fn);
	}
	
	public function forEach(fn:Function):void
	{
		_currentPage.forEach(fn);
	}
	
}

}


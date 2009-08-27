package com.thingsiam.layout {

import com.thingsiam.iterators.*;

import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.Event;
import flash.geom.Rectangle;

public class Paginator extends Sprite {
	
	protected var _pages:Array;	//contains only LayoutArray objects
	protected var _currentPage:LayoutArray;
	protected var _currentIndex:int=0;
	protected var _layoutType:Class;
	protected var _layoutParameters:Object;
	protected var _wrapEnd:Boolean = false;
	
	public static const PAGECOUNT_CHANGE:String="countChange";
	public static const SIZE_CHANGE:String="sizeChange";
	public static const TURN:String="pageTurn";
	
	public function Paginator( layout:Class, args:Object )
	{
		super();
		_layoutType =  		layout;
		_layoutParameters = args;
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
		dispatchEvent( new PaginationEvent( PaginationEvent.BEFORE_PAGE_CHANGE ));
		id = constrainPageID(id);
		if( _pages[id] == _currentPage )
		{	//already there
			return;
		}		
		setPage(id);
	}
	
	public function getPageWhere( f:Function ):LayoutArray
	{
		for each( var page:LayoutArray in _pages )
		{
			if( f(page) )
			{
				return page;
			}	
		}
		
		return currentPage;
	}
	
	public function next():void
	{
		requestPage(_currentIndex+1);
	}
	
	public function previous():void
	{
		requestPage(_currentIndex-1);
	}
	
	public function nextPage():LayoutArray
	{
		var id:int = _currentIndex+1;
		if( id >= _pages.length ){ id = 0; }
		return _pages[id];
	}
	
	public function previousPage():LayoutArray
	{
		var id:int = _currentIndex-1;
		if( id < 0 ){ id = _pages.length-1; }
		return _pages[id];
	}
	
	protected function setPage(id:int):void
	{
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
	
	public function getPageRect():Rectangle
	{
		return _pages[0].getRect(_pages[0]);
	}
	
	public function changeLayout( layout:Class, params:Object )
	{
		_layoutType = layout;
		_layoutParameters = params;
		
		var allItems:Array = new Array();
		for each( var page:LayoutArray in _pages )
		{
			page.forEach( function(d:DisplayObject){ allItems.push(d); }); 
		}
		trace(allItems);
		dump();
		
		for each( var d:DisplayObject in allItems )
		{
			push(d);
		}
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
		dispatchEvent( new Event(SIZE_CHANGE) );	//announce possible change in size 
	}
	
	protected function addPage():void
	{
		_pages.push( new _layoutType(_layoutParameters) );
		dispatchEvent( new Event(PAGECOUNT_CHANGE) );	//announce change in pagecount
	}
	
	public function dump():void
	{
		if( _currentPage && contains(_currentPage)) removeChild(_currentPage);
		for each( var page:LayoutArray in _pages )
		{
			page.dump();
		}
		_pages = new Array();
		addPage();
		requestPage(0);
		dispatchEvent( new Event(PAGECOUNT_CHANGE) );
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
	
	public function get currentPage():LayoutArray{
		return _currentPage;
	}
	
	public function get layoutType():Class{
		return _layoutType;
	}
	
	public function itemWidth(index:int):Number{
		return _currentPage.itemWidth(index);
	}
	
	public function set wrapEnd(value:Boolean):void {
		_wrapEnd = value;
	}
	
	//
	//	Layout function wrappers
	//
	
	public function forEachPage(fn:Function):void
	{
		for each( var p:LayoutArray in _pages )
		{
			fn(p);
		}
	}
	
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


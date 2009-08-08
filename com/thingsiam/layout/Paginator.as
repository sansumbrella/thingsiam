package com.thingsiam.layout {

import flash.display.Sprite;
import flash.display.DisplayObject;
import flash.events.Event;

import com.thingsiam.iterators.*;

public class Paginator extends Sprite {
	
	protected var _pages:Array;	//contains only LayoutArray objects
	protected var _currentPage:LayoutArray;
	protected var _currentIndex:int=0;
	protected var _layoutType:Class;
	protected var _layoutParameters:Object;
	protected var _wrapEnd:Boolean = false;
	
	public static const RESIZE:String="resize";
	public static const TURN:String="pageTurn";
	
	public function Paginator( args:Object )
	{
		super();
		_layoutType =  		args.hasOwnProperty("type") ? args.type : ColumnArray;
		_layoutParameters = args.hasOwnProperty("params") ? args.params : {margin:5};
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
		id = constrainPageID(id);
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
	
	protected function addPage():void
	{
		_pages.push( new _layoutType(_layoutParameters) );
		dispatchEvent( new Event(RESIZE) );	//announce change in size
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


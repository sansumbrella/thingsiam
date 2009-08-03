package com.thingsiam.layout {

import flash.display.Sprite;

public class Paginator extends Sprite {
	
	private var _pages:Array;	//contains only LayoutArray objects
	private var _currentPage:LayoutArray;
	
	public function Paginator()
	{
		super();
	}
	
	public function requestPage( id:int ):void
	{
		
	}
	
	public function push( item:DisplayObject ):void
	{
		_currentPage.push(item);
	}
	
}

}


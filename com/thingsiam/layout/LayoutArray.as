package com.thingsiam.layout {

import flash.display.Sprite;
import flash.display.DisplayObject;

public class LayoutArray extends Sprite {
	
	private var _maxElements:int = 0; // Number of elements allowed in this layout, 0 = infinity
	
	public function LayoutArray()
	{
		super();
	}
	
	public function pushGroup( ... items ):void
	{
		for each( var item in items )
		{
			push(item);
		}
	}
	
	public function push(item:DisplayObject, extraMargin:Number=0):void
	{
		addChild(item);
	}
	
	public function forEach( fn:Function ):void
	{	//passes each child as the parameter to a given function
		for( var i:int=0; i != numChildren; i++ )
		{
			fn(getChildAt(i));
		}
	}
	
	public function eachIf( fn:Function, condition:Function ):void
	{	//passes each child as the parameter to a given function if a condition is met
		for( var i:int=0; i != numChildren; i++ )
		{
			var c:DisplayObject = getChildAt(i);
			if( condition(c) )
			{
				fn( c );
			}
		}
	}
	
	public function get( index:int ):DisplayObject
	{
		return( getChildAt( index ) );
	}
	
	public function get length():int
	{
		return numChildren;
	}
	
	public function dump() : void 
	{
		while( numChildren != 0 ) removeChildAt( 0 );
	}
}

}


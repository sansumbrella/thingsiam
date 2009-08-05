package com.thingsiam.layout {

import flash.display.Sprite;
import flash.display.DisplayObject;

public class LayoutArray extends Sprite {
	
	protected var _maxElements:int = -1; // Number of elements allowed in this layout, -1 = infinity
	
	public function LayoutArray( maxElements:int=-1 )
	{
		super();
		_maxElements = maxElements;
	}
	
	public function pushGroup( ... items ):void
	{
		for each( var item in items )
		{
			push(item);
		}
	}
	
	public function push(item:DisplayObject):Boolean
	{
		addChild(item);
		return true;
	}
	
	public function forEach( fn:Function ):void
	{	//passes each child as the parameter to a given function
		for( var i:int=0; i != numChildren; i++ )
		{
			fn(getChildAt(i));
		}
	}
	
	public function forEachWithIndex( fn:Function ):void
	{
		for( var i:int=0; i != numChildren; i++ )
		{
			fn( getChildAt(i), i );
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
	
	public function cleanup():void
	{
		
	}
	
	public function get( index:int ):DisplayObject
	{
		return( getChildAt( index ) );
	}
	
	public function get length():int
	{
		return numChildren;
	}
	
	public function get maxElements():int{
		return _maxElements;
	}
	
	public function set maxElements(value:int):void {
		_maxElements = value;
	}
	
	public function dump() : void 
	{
		while( numChildren != 0 ) removeChildAt( 0 );
	}
}

}


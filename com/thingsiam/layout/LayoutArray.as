package com.thingsiam.layout {

import flash.display.DisplayObject;
import flash.display.Sprite;

public class LayoutArray extends Sprite {
	
	public static const UNLIMITED:int = -1;
	protected var _maxElements:int = UNLIMITED; // Number of elements allowed in this layout
	
	public function LayoutArray( args:Object=null )
	{
		super();
		if( args == null ) args = {};
		_maxElements = args.hasOwnProperty("maxElements") ? args.maxElements : UNLIMITED;
	}
	
	public function pushGroup( ... items ):void
	{
		for each( var item:DisplayObject in items )
		{
			push(item);
		}
	}
	
	public function push(item:DisplayObject):Boolean
	{
		if( numChildren == _maxElements ){
			return false;
		}
		addChild(item);
		item.addEventListener( LayoutEvent.RESIZE, handleItemResize );
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
	
	private function handleItemResize(e:LayoutEvent):void
	{	//reposition stuff
		cleanup();
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
		while( numChildren != 0 )
		{
			removeChildAt( 0 ).removeEventListener( LayoutEvent.RESIZE, handleItemResize );
		}
	}
	
	public function itemWidth(index:int):Number{
		if( index < numChildren )
			return getChildAt(index).width;
		else
			return 0;
	}
}

}


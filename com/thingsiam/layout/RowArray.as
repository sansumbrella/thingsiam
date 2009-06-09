package com.thingsiam.layout {

import flash.display.Sprite;
import flash.display.DisplayObject;

/**
*	Keeps objects arranged in a row	
*/

public class RowArray extends Sprite {
	
	private var margin:Number;
	
	public function RowArray( _margin:Number = 6 )
	{
		super();
		
		margin = _margin;
	}
	
	public function remove( _item:DisplayObject ):int
	{
		if( contains(_item) )
		{
			var ret:int = getChildIndex( _item );
			removeChild( _item );
			
			for( var i:int=0; i != numChildren; i++ )
			{
				if( getChildAt(i).x > _item.x )
				{
					getChildAt(i).x -= _item.width + margin;
				}
			}
			return ret;
		} else
		{
			return -1;
		}
	}
	
	public function cleanup():void
	{
		var xPos:Number = 0;
		
		for( var i:int=0; i != numChildren; i++ )
		{
			var d:DisplayObject = getChildAt(i);
			d.x = xPos;
			xPos += d.width + margin;
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
	
	public function get first() : DisplayObject 
	{
		var winner:DisplayObject = getChildAt(0);
		for( var i:int = 0; i < numChildren; i++ ){
			if( getChildAt(i).x < winner.x ) winner = getChildAt(i);
		}
		return winner; 
	}
	
	public function get last() : DisplayObject
	{ 
		var winner:DisplayObject = getChildAt(numChildren-1);
		for( var i:int = 0; i < numChildren; i++ ){
			if( getChildAt(i).x > winner.x ) winner = getChildAt(i);
		}
		return winner;
	}
	
	public function push( _item:DisplayObject, _extraMargin:Number=0 ):void
	{
		if( numChildren != 0 )
		{
			_item.x = width + margin + _extraMargin;
		} 
		else _item.x = 0;
		
		addChild( _item );
	}
	
	public function insertAt( _item:DisplayObject, _level:int ):void
	{
		
		if( numChildren != 0 ){
			addChildAt( _item, _level );
			var xPos:Number = 0;
			for( var i:int = 0; i < _level; i++ ){
				xPos += getChildAt( i ) + margin;
			}
			_item.x = xPos;

			for( i = _level+1; i < numChildren; i++ ){
				getChildAt( i ).x += (_item.width + margin);
			}
		} else {
			push( _item );
		}
		
	}
	
	public function each( fn:Function ):void
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
			var c = getChildAt(i);
			if( condition(c) )
			{
				fn( c );
			}
		}
	}
}

}


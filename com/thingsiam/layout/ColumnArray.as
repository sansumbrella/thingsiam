package com.thingsiam.layout {

import flash.display.Sprite;
import flash.display.DisplayObject;

/**
*	Keeps objects arranged in a column
*/

public class ColumnArray extends Sprite {
	
	private var margin:Number;
	
	public function ColumnArray( margin:Number = 6 )
	{
		super();
		this.margin = margin;
	}
	
	public function remove( _item:DisplayObject ):void
	{
		if( contains(_item) )
		{
			for( var i:int=0; i != numChildren; i++ )
			{
				if( getChildAt(i).y > _item.y )
				{
					getChildAt(i).y -= _item.height + margin;
				}
			}
			removeChild( _item );
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
			if( getChildAt(i).y < winner.y ) winner = getChildAt(i);
		}
		return winner; 
	}
	
	public function get last() : DisplayObject
	{ 
		var winner:DisplayObject = getChildAt(numChildren-1);
		for( var i:int = 0; i < numChildren; i++ ){
			if( getChildAt(i).y > winner.y ) winner = getChildAt(i);
		}
		return winner;
	}
	
	public function push( _item:DisplayObject ):void
	{
		if( numChildren != 0 )
		{
			_item.y = height + margin;
		} 
		else _item.y = 0;
		
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
			_item.y = xPos;

			for( i = _level+1; i < numChildren; i++ ){
				getChildAt( i ).y += (_item.height + margin);
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


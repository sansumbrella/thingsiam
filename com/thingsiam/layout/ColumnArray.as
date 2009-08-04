package com.thingsiam.layout {

import flash.display.Sprite;
import flash.display.DisplayObject;

/**
*	Keeps objects arranged in a column
*/

public class ColumnArray extends LayoutArray {
	
	private var margin:Number;
	
	public function ColumnArray( margin:Number = 6, maxElements:int=-1 )
	{
		super(maxElements);
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
	
	override public function cleanup():void
	{
		var yPos:Number = 0;
		
		for( var i:int=0; i != numChildren; i++ )
		{
			var d:DisplayObject = getChildAt(i);
			d.y = yPos;
			yPos += d.height + margin;
		}
	}
	
	override public function push( item:DisplayObject ):Boolean
	{
		if( numChildren == _maxElements )
		{
			return false;
		}
			
		if( numChildren != 0 )
		{
			item.y = bottom + margin;
		} else 
		{
			item.y = 0;
		}
		
		addChild( item );
		return true;
	}
	
	public function get bottom():Number{
		var obj:DisplayObject = last;
		return obj.y + obj.height;
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
}

}


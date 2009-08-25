package com.thingsiam.layout {

import flash.display.DisplayObject;
import flash.geom.Rectangle;

/**
*	Keeps objects arranged in a row	
*/

public class RowArray extends LayoutArray {
	
	private var _margin:Number;
	
	public function RowArray( args:Object=null )
	{
		if( args == null ) args = {};
		super(args);
		_margin = args.hasOwnProperty("margin") ? args.margin : 5;
	}
	
	public function remove( item:DisplayObject ):int
	{
		if( contains(item) )
		{
			var ret:int = getChildIndex( item );
			removeChild( item );
			
			for( var i:int=0; i != numChildren; i++ )
			{
				if( getChildAt(i).x > item.x )
				{
					getChildAt(i).x -= item.width + _margin;
				}
			}
			return ret;
		} else
		{
			return -1;
		}
	}
	
	override public function cleanup():void
	{
		var xPos:Number = 0;
		
		//left-to-right
		
		for( var i:int=0; i != numChildren; i++ )
		{
			var d:DisplayObject = getChildAt(i);
			d.x = xPos;
//			var rect:Rectangle = d.getBounds( d );			
			xPos += d.width + _margin;	//get the right edge
		}
		//right-to-left
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
	
	public function get right():Number{
		//since width might not reflect the actual right edge
		var obj:DisplayObject = last;
		return obj.x + obj.width;
	}
	
	override public function push( item:DisplayObject ):Boolean
	{
		if( numChildren != 0 )
		{
			item.x = right + _margin;
		} 
		else item.x = 0;
		
		return super.push(item);
	}
	
	public function insertAt( item:DisplayObject, level:int ):void
	{
		
		if( numChildren != 0 ){
			addChildAt( item, level );
			var xPos:Number = 0;
			for( var i:int = 0; i < level; i++ ){
				xPos += getChildAt( i ) + _margin;
			}
			item.x = xPos;

			for( i = level+1; i < numChildren; i++ ){
				getChildAt( i ).x += (item.width + _margin);
			}
		} else {
			push( item );
		}
	}
}

}


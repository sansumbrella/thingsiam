package com.thingsiam.layout {

import flash.display.DisplayObject;

public class GridArray extends LayoutArray {
	
	/**
	*	A basic grid layout
	*	Items go in left—right, top—bottom	
	*	
	*/
	
	private var _marginX		:Number,
				_marginY		:Number,
				_rows			:int,
				_columns		:int,
				_currentRow		:int,
				_currentColumn	:int;
	
	public function GridArray( marginX:Number = 10, marginY:Number = 10, rows:int = 2, columns:int = 2 )
	{
		super(rows*columns);
		_marginX = marginX;
		_marginY = marginY;
		_rows = rows;
		_columns = columns;
		_currentRow = 0;
		_currentColumn = 0;
	}
	
	override public function push(item:DisplayObject):Boolean
	{
		if( numChildren == _maxElements )
		{
			return false;
		}
		if( numChildren != 0 )
		{
			item.x = last.x + last.width + _marginX;
			item.y = last.y;
		}
		
		_currentColumn++;
		if(_currentColumn == _columns)
		{
			_currentColumn = 0;
			_currentRow++;
			item.y += _marginY + last.height;
		}
		
		addChild(item);
		return true;
	}
	
	public function get last():DisplayObject{
		return getChildAt(numChildren-1);
	}
	
}

}


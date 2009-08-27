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
				_columnSize		:Number,
				_rowSize		:Number,
				_rows			:int,
				_columns		:int,
				_currentRow		:int,
				_currentColumn	:int;
	
	public function GridArray( args:Object=null )
	{	
		if( args == null ) args = {};
		_rowSize	 	= 	args.hasOwnProperty("rowSize") ? 	args.rowSize : 	100;
		_columnSize		= 	args.hasOwnProperty("columnSize") ? args.columnSize : 100;
		_marginX = 	args.hasOwnProperty("marginX") ? args.marginX : 0;
		_marginY = 	args.hasOwnProperty("marginY") ? args.marginY : 0;
		_rows = 	args.hasOwnProperty("rows") 	? args.rows : 2;
		_columns = 	args.hasOwnProperty("columns") ? args.columns : 2;
		_currentRow = 0;
		_currentColumn = 0;
		args["maxElements"] = _rows*_columns;
		super(args);
		
	}
	
	override public function push(item:DisplayObject):Boolean
	{
		item.x = _currentColumn * _columnSize + _marginX;
		item.y = _currentRow * _rowSize + _marginY;
		
		_currentColumn++;
		if(_currentColumn == _columns)
		{
			_currentColumn = 0;
			_currentRow++;
		}
		
		return super.push(item);
	}
	
	public function get last():DisplayObject{
		return getChildAt(numChildren-1);
	}
	
}

}


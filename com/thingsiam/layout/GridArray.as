package com.thingsiam.layout {

import flash.display.Sprite;

public class GridArray extends LayoutArray {
	
	/**
	*	A basic grid layout
	*	Items go in left—right, top—bottom	
	*	
	*/
	
	private var _marginX	:Number,
				_marginY	:Number,
				_rows		:int,
				_columns	:int;
	
	public function GridArray( marginX:Number = 10, marginY:Number = 10, rows:int = 2, columns:int = 2 )
	{
		super();
	}
	
}

}


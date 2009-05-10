package examples {

import flash.display.Sprite;
import flash.display.Shape;
import flash.display.StageAlign;
import flash.display.StageScaleMode;

import com.thingsiam.color.ColorUtils;
import com.thingsiam.layout.RowArray;

[SWF(width=800, height=600, backgroundColor=0x000000, frameRate=30)]

public class Colors extends Sprite {
	
	/**
	*	@author: David Wicks
	*	@url: http://sansumbrella.com
	*	Creates two rows of colored blocks
	*	The top row is a linear interpolation between COLOR_ONE and COLOR_TWO
	*	The bottom row is the inverse color of each step
	*	
	*	Demonstrates the functions in ColorUtils as well as basic RowArray use	
	*	
	*/
	
	private const COLOR_ONE:uint = 0xFF00FF;
	private const COLOR_TWO:uint = 0x00FFFF;
	private var numSteps:int = 10;
	private var topRow:RowArray;
	private var bottomRow:RowArray;
	
	public function Colors()
	{
		super();
		init();
	}
	
	private function init():void
	{
		stage.align = StageAlign.TOP_LEFT;
		stage.scaleMode = StageScaleMode.NO_SCALE;
		
		topRow = new RowArray(0);
		bottomRow = new RowArray(0);
		addChild(topRow);
		addChild(bottomRow);
		for( var i:int=0; i != numSteps; i++ )
		{
			var col:uint = ColorUtils.lerpColor(COLOR_ONE, COLOR_TWO, i/(numSteps-1));
			topRow.push(createShape( col ));
			bottomRow.push(createShape( ColorUtils.invert(col) ));
		}
		
		topRow.y = 200;
		bottomRow.y = topRow.y + topRow.height;
		bottomRow.x = topRow.x = (800-topRow.width)/2;
	}
	
	private function createShape( fill:uint, w:Number=50, h:Number=50 ):Shape
	{
		var shape:Shape = new Shape();
		shape.graphics.beginFill(fill,1);
		shape.graphics.drawRect(0,0,w,h);
		shape.graphics.endFill();
		return shape;
	}
	
}

}


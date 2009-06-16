package com.thingsiam.display {

import flash.display.Sprite;
import flash.display.Shape;

public class BasicPreloaderView extends Sprite implements IProgressIndicator {

	private var _loadFill:Shape;
	private var _loadOutline:Shape;
	
	public function BasicPreloaderView( w:Number=100, h:Number=4 )
	{
		super();
		_loadFill = new Shape();
		with( _loadFill.graphics ){
			beginFill( 0xFFFFFF, 1.0 );
			drawRect( 0, 0, w, h );
			endFill();
		}
		_loadOutline = new Shape();
		with( _loadOutline.graphics ){
			lineStyle( 1, 0xFFFFFF, 1.0 );
			drawRect( 0, 0, w, h );
			endFill();
		}
		
		addChild( _loadFill );
		addChild( _loadOutline );
		
		_loadFill.scaleX = 0;
	}
	
	public function displayProgress( ratio:Number ):void
	{
		_loadFill.scaleX = ratio;
	}
	
	public function show():void
	{
		
	}
	
	public function hide(onComplete:Function):void
	{
		onComplete();
	}
	
}

}


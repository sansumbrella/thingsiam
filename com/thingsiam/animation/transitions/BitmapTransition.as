package com.thingsiam.animation.transitions {
	
	/*
	*	@author David Wicks
	*	@since  22.07.2008
	*/
	
	import flash.display.Sprite;
	import flash.display.Shape;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.geom.ColorTransform;
	
	import flash.events.Event;
	
	public class BitmapTransition extends Sprite {
		
		public var isChanging		:Boolean;
		protected var start			:Bitmap;
		protected var end			:Bitmap;
		protected var trans			:Boolean;
		protected var startImage	:BitmapData;
		protected var endImage		:BitmapData;
		protected var startMask		:Shape;
		protected var endMask		:Shape;
		protected var startRect, endRect:Rectangle;
		private var clearTransform	:ColorTransform;
		
		public function BitmapTransition( w:Number = 852, h:Number = 476, bgColor:uint = 0xFFFFFF, trans:Boolean = true ){
			
			clearTransform = trans? new ColorTransform( 0, 0, 0, 0, 0, 0, 0, 0 ) : new ColorTransform( 0, 0, 0, 1, 0, 0, 0, 0);
			clearTransform.color = bgColor;
			
			this.trans = trans;
			
			startImage = new BitmapData( w, h, trans, bgColor );
			start = new Bitmap( startImage );
			endImage = new BitmapData( w, h, trans, bgColor );
			end = new Bitmap( endImage );
			
			startMask = new Shape();			
			endMask = new Shape();
			drawMasks( w, h );
			
			start.mask = startMask;
			end.mask = endMask;
			
			addChild( start );
			addChild( end );
			addChild( startMask );
			addChild( endMask );
		}
		
		//draw to canvas
		//play out canvas
		//play in new canvas
		//report play complete
		
		public function transition( start:DisplayObject, end:DisplayObject ) : void {
			setStart( start );
			setEnd( end );
			
			startTransition();
		}
		
		public function resize( w:Number, h:Number ) : void {
			removeChild( start );
			removeChild( end );
			startImage = new BitmapData( w, h, trans, clearTransform.color );
			start = new Bitmap( startImage );
			endImage = new BitmapData( w, h, trans, clearTransform.color );
			end = new Bitmap( endImage );
			drawMasks( w, h );
			addChild( start );
			addChild( end );
			start.mask = startMask;
			end.mask = endMask;
		}
		
		private function drawMasks( w:Number, h:Number ) : void {
			startMask.graphics.clear();
			startMask.graphics.beginFill( 0 );
			startMask.graphics.drawRect( 0, 0, w, h );
			startMask.graphics.endFill();
			endMask.graphics.clear();
			endMask.graphics.beginFill( 0 );
			endMask.graphics.drawRect( 0, 0, w, h );
			endMask.graphics.endFill();
		}
		
		public function setStart( start:DisplayObject ) : void {
			startImage.colorTransform( startImage.rect, clearTransform );
			startImage.draw( start, start.transform.matrix );
			startRect = start.getBounds(start);
			startRect.x = start.x;		startRect.y = start.y;
		}
		
		public function self():Bitmap {
			var bmd:BitmapData = new BitmapData( width, height, trans, clearTransform.color );
			bmd.draw(this);
			return new Bitmap(bmd);
		}
		
		public function setEnd( end:DisplayObject ) : void {
			endImage.colorTransform( endImage.rect, clearTransform );
			endImage.draw( end, end.transform.matrix );
			endRect = end.getBounds(end);
			endRect.x = end.x;		end.y = end.y;
		}
		
		public function startTransition() : void {
			isChanging = true;
			playTransition();
		}
		
		protected function playTransition() : void {
			//override this function to create animation effects
			handleComplete();
		}
		
		protected function handleComplete() : void {
			isChanging = false;
			dispatchEvent( new Event( Event.COMPLETE ) );
		}
		
	}
	
}

package com.thingsiam.display {
	
	/**
	*	@author David Wicks
	*	@since  22.07.2008
	*	
	*	A simple progress bar. Cleans itself up after load is complete
	*/
	
	import flash.events.EventDispatcher;
	import flash.events.*;
	
	import flash.display.Sprite;
	import flash.display.Shape;
	
	import gs.TweenLite;
	
	public class BasicPreloader extends Sprite {
		
		private var loadFill:Shape;
		private var loadOutline:Shape;

		public function BasicPreloader( w:Number = 100, h:Number = 10 ){
			
			loadFill = new Shape();
			with( loadFill.graphics ){
				beginFill( 0xFFFFFF, 1.0 );
				drawRect( 0, 0, w, h );
				endFill();
			}
			loadOutline = new Shape();
			with( loadOutline.graphics ){
				lineStyle( 1, 0xFFFFFF, 1.0 );
				drawRect( 0, 0, w, h );
				endFill();
			}
			
			addChild( loadFill );
			addChild( loadOutline );
			
			loadFill.scaleX = 0;
		}
		
		public function observe( observed:EventDispatcher ){
			observed.addEventListener( ProgressEvent.PROGRESS, handleProgress, false, 0, true );
			observed.addEventListener( Event.COMPLETE, handleComplete, false, 0, true );
			observed.addEventListener( Event.OPEN, handleStart, false, 0, true );
			
			loadFill.scaleX = 0;
		}
		
		public function ignore( observed:EventDispatcher ) : void {
			observed.removeEventListener( ProgressEvent.PROGRESS, handleProgress );
			observed.removeEventListener( Event.COMPLETE, handleComplete );
			observed.removeEventListener( Event.OPEN, handleStart );
			
			visible = false;
			if( parent ) parent.removeChild( this );
		}
		
		private function handleStart( e:Event ) : void {
			visible = true;
		}
		
		private function handleProgress( e:ProgressEvent ) : void {
			loadFill.scaleX = e.bytesLoaded/e.bytesTotal;
		}
		
		private function handleComplete( e:Event ) : void {
			if( parent ) parent.removeChild( this );
		}
		
	}
	
}

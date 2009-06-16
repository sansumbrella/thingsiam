package com.thingsiam.display {
	
	/**
	*	@author David Wicks
	*	@since  22.07.2008
	*	
	*	A simple progress bar. Cleans itself up after load is complete
	*	To change the progress display, create an object that implements IProgressIndicator and assign it as the view
	*	
	*/
	
	import flash.events.EventDispatcher;
	import flash.events.*;
	
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	
	import gs.TweenLite;
	
	public class BasicPreloader extends Sprite {
		
		private var _view:IProgressIndicator;
		
		public function BasicPreloader( view:IProgressIndicator=null ){
			if( view == null )
			{
				_view = new BasicPreloaderView;
			}
			addChild( _view as DisplayObject );
		}
		
		public function observe( observed:EventDispatcher ){
			observed.addEventListener( ProgressEvent.PROGRESS, handleProgress, false, 0, true );
			observed.addEventListener( Event.COMPLETE, handleComplete, false, 0, true );
			observed.addEventListener( Event.OPEN, handleStart, false, 0, true );
		}
		
		public function ignore( observed:EventDispatcher ) : void {
			removeListeners(observed);			
			_view.hide(removeFromStage);
		}
		
		private function handleStart( e:Event ) : void {
			_view.show();
		}
		
		private function handleProgress( e:ProgressEvent ) : void {
			_view.displayProgress(e.bytesLoaded/e.bytesTotal);
		}
		
		private function handleComplete( e:Event ) : void {
			removeListeners( e.target as EventDispatcher );
			_view.hide(removeFromStage);
		}
		
		private function removeFromStage():void
		{
			if( parent ) parent.removeChild( this );
		}
		
		private function removeListeners( observed:EventDispatcher ):void
		{
			observed.removeEventListener( ProgressEvent.PROGRESS, handleProgress );
			observed.removeEventListener( Event.COMPLETE, handleComplete );
			observed.removeEventListener( Event.OPEN, handleStart );
		}
		
		public function set view(value:IProgressIndicator):void {
			if( contains(_view as DisplayObject) )
			{
				removeChild(_view as DisplayObject);
			}
			_view = value;
			addChild(_view as DisplayObject);
		}
		
	}
	
}

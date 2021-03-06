package com.thingsiam.loading {
	
	/**
	*	@author David Wicks
	*	@since  22.07.2008
	*	
	*	A flexible preloader. The view is composed in, so you can use anything that implements IProgressIndicator
	*	Shows/hides the view at the beginning/end of loading.
	*	To change the progress display, create an object that implements IProgressIndicator and assign it as the view
	*	
	*/
	
	import flash.events.*;
	import flash.display.DisplayObject;
	
	public class BasicPreloader extends Object {
		
		private var _view:IProgressIndicator;
		private var _loadStarted:Boolean = false;
		
		public function BasicPreloader( view:IProgressIndicator=null )
		{
			_view = view;
			if( view == null )
			{
				_view = new BasicPreloaderView;
			}
		}
		
		public function observe( observed:EventDispatcher ) : void 
		{
			_loadStarted = false;
			observed.addEventListener( ProgressEvent.PROGRESS, handleProgress, false, 0, true );
			observed.addEventListener( Event.COMPLETE, handleComplete, false, int.MAX_VALUE, true );
			observed.addEventListener( Event.OPEN, handleStart, false, 0, true );
		}
		
		public function ignore( observed:EventDispatcher ) : void
		{
			removeListeners(observed);			
			_view.hide();
		}
		
		private function handleStart( e:Event ) : void
		{
			_loadStarted = true;
			_view.show();
			_view.displayProgress(0);
		}
		
		private function handleProgress( e:ProgressEvent ) : void
		{
			if( !_loadStarted )
			{	//in case we're assigned to listen after the fact (or flash doesn't send the start event! (it doesn't))
				handleStart(e);
			}
			_view.displayProgress(e.bytesLoaded/e.bytesTotal);
		}
		
		private function handleComplete( e:Event ) : void 
		{
			removeListeners( e.target as EventDispatcher );
			_view.hide();
		}
		
		private function removeListeners( observed:EventDispatcher ):void
		{
			observed.removeEventListener( ProgressEvent.PROGRESS, handleProgress );
			observed.removeEventListener( Event.COMPLETE, handleComplete );
			observed.removeEventListener( Event.OPEN, handleStart );
		}
		
		public function set view(value:DisplayObject):void {
			if( !(value is IProgressIndicator) ) throw new Error("Preloader view must implement IProgressIndicator. The cast to DisplayObject inside the getter/setter is for your convenience.");
			_view = value as IProgressIndicator;
		}
		
		public function get view():DisplayObject {
			return _view as DisplayObject;
		}
		
		/*
			Wrappers for _view functions
		*/
		
		public function set x(value:Number):void {
			(_view as DisplayObject).x = value;
		}
		
		public function set y(value:Number):void {
			(_view as DisplayObject).y = value;
		}
		
		public function get width():Number{
			return (_view as DisplayObject).width;
		}
		
		public function get height():Number{
			return (_view as DisplayObject).height;
		}
	}
	
}

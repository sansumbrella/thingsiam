package com.thingsiam.display {

import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Rectangle;

public class ScrollBar extends Sprite {
	
	/**
	*	Composes a handle and a track and sets up mouse dragging for the handle along the track	
	*	dispatches CHANGE events while dragging
	*	public adjustScale() function for when scrolled content changes size, if you need it
	*	subclass it to define your handle and track (init could be made public to allow more freeform usage)
	*/
	
	protected var _handle:Sprite;
	protected var _track:Sprite;
	private var _scrollBounds:Rectangle;
	private var _orientation:int;
	private var _offset:Number;
	private var _scrolling:Boolean = false;
	
	public static const HORIZONTAL:int=0;
	public static const VERTICAL:int=1;
	
	public function ScrollBar()
	{
		super();
	}
	
	protected function initControls(orient:int=HORIZONTAL):void
	{
		_handle.buttonMode = true;
		_handle.mouseChildren = false;
		
		addChild(_track);
		addChild(_handle);
		_handle.addEventListener( MouseEvent.MOUSE_DOWN, handleDragStart );
		_orientation = orient;
		
		switch (_orientation)
		{
			case HORIZONTAL:
				_scrollBounds = new Rectangle( _handle.x, _handle.y, _track.width-_handle.width, _handle.y);
				_offset = _handle.x;
			break;
			case VERTICAL:
				_scrollBounds = new Rectangle( _handle.x, _handle.y, _handle.x, _track.height-_handle.height);
				_offset = _handle.y;
			break;
			default:
				throw new Error("ScrollBar needs to be either HORIZONTAL or VERTICAL. Use the constants provided in the class for initialization.")
			break;
		}
	}
	
	public function adjustScale( windowRect:Rectangle, contentRect:Rectangle ):void
	{
		switch (_orientation)
		{
			case HORIZONTAL:
				if( contentRect.width == 0 ) break;
				scaleHandle( windowRect.width/contentRect.width );
			break;
			case VERTICAL:
				if( contentRect.height == 0 ) break;
				scaleHandle(windowRect.height/contentRect.height);
			break;
			default:
			break;
		}
		
		updateScrollBounds();
	}
	
	protected function updateScrollBounds():void
	{
		switch(_orientation)
		{
			case HORIZONTAL:
				_scrollBounds.width = _track.width - _handle.width;
				break;
			case VERTICAL:
				_scrollBounds.height = _track.height - _handle.height;
				break;
			default:
			break;
		}
	}
	
	protected function scaleHandle(scale:Number):void
	{
		//make sure to override this if you want it to do something
	}
	
	private function handleDragStart( e:MouseEvent ):void
	{		
		_handle.startDrag( false, _scrollBounds );
		stage.addEventListener( MouseEvent.MOUSE_MOVE, handleDragUpdate );
		stage.addEventListener( MouseEvent.MOUSE_UP, handleDragStop );
		stage.addEventListener( Event.MOUSE_LEAVE, handleDragStop );
		
		_scrolling = true;
	}
	
	private function handleDragUpdate(e:MouseEvent):void
	{	//let the world know
		dispatchEvent( new Event(Event.CHANGE));
	}
	
	private function handleDragStop(e:Event):void
	{
		_handle.stopDrag();
		stage.removeEventListener( MouseEvent.MOUSE_MOVE, handleDragUpdate );
		stage.removeEventListener( MouseEvent.MOUSE_UP, handleDragStop );
		stage.removeEventListener( Event.MOUSE_LEAVE, handleDragStop );
		
		_scrolling = false;
		dispatchEvent( new Event(Event.COMPLETE));
	}
	
	public function get value():Number{
		return (_orientation==HORIZONTAL) ? _handle.x/(_track.width-(_handle.width+_offset)) : _handle.y/(_track.height-(_handle.height+_offset));
	}
	
	public function set value(value:Number):void {
		if( _scrolling )
		{
			return;
		}
		
		switch (_orientation)
		{
			case HORIZONTAL :
				_handle.x = value*(_track.width-(_handle.width+_offset));
			break;
			case VERTICAL :
				_handle.y = value*(_track.height-(_handle.height+_offset));
			break;
			default:
			break;
		}
	}
}

}


package com.thingsiam.display {
	
	/**
	*	@author David Wicks
	*	@since  15.07.2008
	*	
	*	Wraps basic mouse events and sets button modes so children can just implement handlers (AS2 style)
	*	State management is on the way
	*/
	
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class BasicButton extends Sprite {
		
		protected var _state:String;
		protected var _id:int = 0;
		
		public function BasicButton(){
			assignListeners();
			buttonMode = true;
			mouseChildren = false;
		}
		
		public function addChildAtPosition( child:DisplayObject, _x:Number=0, _y:Number=0 ):void
		{
			child.x = _x;
			child.y = _y;
			addChild( child );
		}
		
		private function assignListeners():void
		{
			addEventListener( MouseEvent.MOUSE_OVER, handleOverEvent, false, 0, true );
			addEventListener( MouseEvent.MOUSE_OUT, handleOutEvent, false, 0, true );
			addEventListener( MouseEvent.CLICK, handleClickEvent, false, 0, true );
			addEventListener( MouseEvent.MOUSE_DOWN, handleDownEvent, false, 0, true );
			addEventListener( MouseEvent.MOUSE_UP, handleUpEvent, false, 0, true );
		}
		
		private function removeListeners():void
		{
			removeEventListener( MouseEvent.MOUSE_OVER, handleOverEvent);
			removeEventListener( MouseEvent.MOUSE_OUT, handleOutEvent);
			removeEventListener( MouseEvent.CLICK, handleClickEvent);
			removeEventListener( MouseEvent.MOUSE_DOWN, handleDownEvent);
			removeEventListener( MouseEvent.MOUSE_UP, handleUpEvent);
		}
		
		private function handleOverEvent( e:Event ) : void {
			handleOver();
		}
		
		private function handleOutEvent( e:Event ) : void {
			handleOut();
		}
		
		private function handleClickEvent( e:Event ) : void {
			handleClick();
		}
		
		private function handleDownEvent( e:Event ):void
		{
			handleDown();
		}
		
		private function handleUpEvent( e:Event ):void
		{
			handleUp();
		}
		
		protected function handleOver() : void {
			
		}
		
		protected function handleOut() : void {

		}
		
		protected function handleClick() : void {
			
		}
		
		protected function handleDown():void
		{
			
		}
		
		protected function handleUp():void
		{
			
		}
		
		public function enable():void
		{
			mouseEnabled = true;
			assignListeners();
		}
		
		public function disable():void
		{
			mouseEnabled = false;
			removeListeners();
		}
		
		public function get id():int{
			return _id;
		}
		
		public function set id(value:int):void {
			_id = value;
		}
		
	}
	
}

package com.thingsiam.display {
	
	/**
	*	@author David Wicks
	*	@since  15.07.2008
	*	
	*	Wraps basic mouse events and sets button modes so children can just implement handlers
	*/
	
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class BasicButton extends Sprite {
		
		private var _hitObject:Sprite;
		
		public function BasicButton(){
			_hitObject = this;
			assignListeners();
		}
		
		private function assignListeners():void
		{
			_hitObject.buttonMode = true;
			_hitObject.mouseChildren = false;
			_hitObject.addEventListener( MouseEvent.MOUSE_OVER, handleOverEvent, false, 0, true );
			_hitObject.addEventListener( MouseEvent.MOUSE_OUT, handleOutEvent, false, 0, true );
			_hitObject.addEventListener( MouseEvent.CLICK, handleClickEvent, false, 0, true );
			_hitObject.addEventListener( MouseEvent.MOUSE_DOWN, handleDownEvent, false, 0, true );
			_hitObject.addEventListener( MouseEvent.MOUSE_UP, handleUpEvent, false, 0, true );
		}
		
		private function removeListeners():void
		{
			_hitObject.buttonMode = false;
			_hitObject.mouseChildren = true;
			_hitObject.removeEventListener( MouseEvent.MOUSE_OVER, handleOverEvent );
			_hitObject.removeEventListener( MouseEvent.MOUSE_OUT, handleOutEvent );
			_hitObject.removeEventListener( MouseEvent.CLICK, handleClickEvent );
			_hitObject.removeEventListener( MouseEvent.MOUSE_DOWN, handleDownEvent );
			_hitObject.removeEventListener( MouseEvent.MOUSE_UP, handleUpEvent );
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
		}
		
		public function disable():void
		{
			mouseEnabled = false;
		}
		
		public function set hitObject(value:Sprite):void {
			removeListeners();
			_hitObject = value;
			assignListeners();
		}
		
	}
	
}

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
		
		public function BasicButton(){
			assignListeners();
		}
		
		private function assignListeners():void
		{
			buttonMode = true;
			mouseChildren = false;
			addEventListener( MouseEvent.MOUSE_OVER, handleOverEvent, false, 0, true );
			addEventListener( MouseEvent.MOUSE_OUT, handleOutEvent, false, 0, true );
			addEventListener( MouseEvent.CLICK, handleClickEvent, false, 0, true );
			addEventListener( MouseEvent.MOUSE_DOWN, handleDownEvent, false, 0, true );
			addEventListener( MouseEvent.MOUSE_UP, handleUpEvent, false, 0, true );
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
		
	}
	
}

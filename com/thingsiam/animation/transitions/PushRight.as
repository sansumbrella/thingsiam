package com.thingsiam.animation.transitions {
	
	/*
	*	@author David Wicks
	*	@since  30.07.2008
	*/
	
	import gs.TweenLite;
	import gs.easing.Quad;
	
	public class PushRight extends Transition {
		
		public function PushRight( w:Number = 852, h:Number = 476 ){
			super( w, h );
		}
		
		override protected function playTransition() : void {
			start.x = 0;
			TweenLite.to( start, 1.25, { x:start.width, ease:Quad.easeInOut } );
			end.x = -end.width;
			TweenLite.to( end, 1.25, { x:0, ease:Quad.easeInOut, onComplete:handleComplete } );
		}
		
	}
	
}

package com.thingsiam.animation.transitions {
	
	/*
	*	@author David Wicks
	*	@since  30.07.2008
	*/
	
	import gs.TweenLite;
	import gs.easing.Quad;
	
	public class Nudge extends Transition {
		
		private var amount:Number = 0;
		private var duration:Number = 0.5;
		
		public function Nudge( amount:Number = 100, duration:Number = 0.5, w:Number = 852, h:Number = 476 ){
			super( w, h );
			this.amount = amount;
			this.duration = duration;
		}
		
		override protected function playTransition() : void {
			start.x = 0;
			TweenLite.to( start, duration, { x:amount, ease:Quad.easeInOut } );
			end.x = -amount;
			TweenLite.to( end, duration, { x:0, ease:Quad.easeInOut, onComplete:handleComplete } );
		}
		
	}
	
}

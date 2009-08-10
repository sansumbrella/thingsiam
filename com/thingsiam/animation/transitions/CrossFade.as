package com.thingsiam.animation.transitions {
	
	/*
	*	@author David Wicks
	*	@since  22.07.2008
	*/
	
	import gs.TweenLite;
	
	public class CrossFade extends Transition {
		
		public function CrossFade( w:Number = 852, h:Number = 476 ){
			super( w, h );
		}
		
		override protected function playTransition() : void {
			start.alpha = 1;
			end.alpha = 0;
			TweenLite.to( start, 1.0, { alpha:0 } );
			TweenLite.to( end, 1.0, { alpha:1, onComplete:handleComplete } );
		}
		
	}
	
}

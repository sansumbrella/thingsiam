package com.thingsiam.animation.transitions{
	
	/*
	*	@author David Wicks
	*	@since  30.07.2008
	*/
	
	import flash.geom.Rectangle;
	
	import gs.TweenLite;
	
	public class WipeFadeRight extends Transition {
		
		public function WipeFadeRight( w:Number = 852, h:Number = 476, bgColor:uint = 0xFFFFFF, trans:Boolean = true ){
			super( w, h, bgColor, trans );
		}
		
		override protected function playTransition() : void {
			endMask.scaleX = 0;
			var widest:Rectangle = widestRect;
			endMask.x = widest.left;
			TweenLite.to( endMask, 1.0, { width:widest.width, ease:Quad.easeInOut } );
			end.alpha = 0.05;
			TweenLite.to( end, 1.25, {alpha:1, onComplete:handleComplete, ease:Quad.easeInOut } );
		}

		private function get widestRect() : Rectangle {
			return ( startRect.width > endRect.width ) ? startRect : endRect;
		}
		
	}
	
}

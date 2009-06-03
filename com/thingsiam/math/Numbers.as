package com.thingsiam.math {
	
	/*
	*	@author David Wicks
	*	@since  08.08.2008
	*/

	public class Numbers extends Object {
				
		public static function map( $in:Number, $inMin:Number, $inMax:Number, $outMin:Number, $outMax:Number ):Number{			
			if( $outMin == 0 ) return (normalize($in, $inMin, $inMax )*$outMax);
			return ( normalize($in, $inMin, $inMax)*( $outMax - $outMin ) + $outMin );
		}
		
		public static function normalize( $in:Number, $min:Number, $max:Number ):Number{
			return ( $in/( $max - $min ) );
		}
		
		public static function limit( $in:Number, $max:Number ):Number
		{
			if( $in < 0 ) return Math.max( $in, -$max );
			return Math.min( $in, $max );
		}
		
	}
	
}

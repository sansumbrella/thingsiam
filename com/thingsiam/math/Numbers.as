package com.thingsiam.math {
	
	/*
	*	@author David Wicks
	*	@since  08.08.2008
	*/
	
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;
	
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
		
		public static function fillProportionally( object:DisplayObject, rect:Rectangle, centerV:Boolean=true, centerH:Boolean=true ):void
		{
			object.width = rect.width;
			object.scaleY = object.scaleX;
			if( object.height < rect.height )
			{	//grow to at least fill height, overflow width
				object.height = rect.height;
				object.scaleX = object.scaleY;
			}
			
			if( centerH )	object.x = ((rect.x+rect.width) - object.width)/2;
			if( centerV )	object.y = ((rect.y+rect.height) - object.height)/2;
		}
		
		public static function fitProportionally( object:DisplayObject, rect:Rectangle, centerV:Boolean=true, centerH:Boolean=true ):void
		{
			object.width = rect.width;
			object.scaleY = object.scaleX;
			if( object.height > rect.height )
			{	//shrink to fit height in space, pad width
				object.height = rect.height;
				object.scaleX = object.scaleY;
			}
			
			if( centerH )	object.x = ((rect.x+rect.width) - object.width)/2;
			if( centerV )	object.y = ((rect.y+rect.height) - object.height)/2;
		}
		
	}
	
}

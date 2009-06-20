package com.thingsiam.color {

import flash.display.BitmapData;
import flash.display.IBitmapDrawable;
import flash.display.DisplayObject;

public class ColorUtils extends Object {
	
	public function ColorUtils()
	{
		super();
	}
	
	public static function lerpColor( col1:uint, col2:uint, amt:Number ):uint
	{
		var r1:uint = col1 >> 16;
		var r2:uint = col2 >> 16;
		var rr:uint = r1 + ( r2 - r1 )*amt;
		var g1:uint = col1 >> 8 & 0xFF;
		var g2:uint = col2 >> 8 & 0xFF;
		var gg:uint = g1 + ( g2 - g1 )*amt;
		var b1:uint = col1 & 0xFF;
		var b2:uint = col2 & 0xFF;
		var bb:uint = b1 + ( b2 - b1 )*amt;
		
		return rr << 16 | gg << 8 | bb;
	}
	
	public static function invert( col:uint ):int
	{
		return col ^ 0xFFFFFF;
		/*
		var r:uint = col >> 16;
		var g:uint = col >> 8 & 0xFF;
		var b:uint = col & 0xFF;
		
		r = invertChannel(r);
		g = invertChannel(g);
		b = invertChannel(b);
		
		return r << 16 | g << 8 | b;
		*/
	}
	
	public static function invertChannel( channel:uint ):int
	{
		return channel ^ 0xFF;
		/*
		channel = Math.min( channel, 255 );
		channel = Math.max( channel, 0 );
		if( channel == 128 ) return channel;
		return channel > 128 ? (127 - (channel-128)) : (128-channel)+127;
		*/
	}
	
	public static function averageColor( src:IBitmapDrawable ):uint
	{
		var pixels:BitmapData;
		var r:uint = 0;
		var g:uint = 0;
		var b:uint = 0;
		
		//get our BitmapData to work with
		if( src is BitmapData )
		{
			pixels = src as BitmapData;
		} else if( src is DisplayObject )
		{
			pixels = new BitmapData( (src as DisplayObject).width, (src as DisplayObject).height, false );
			pixels.draw( src );
		} else
		{	//not sure how this would happen
			throw new Error("You must pass something that either is a BitmapData or can be drawn into one.");
		}
		
		//calculate the average color
		for( var w:int=0; w!= pixels.width; w++ )
		{
			for( var h:int=0; h!= pixels.height; h++ )
			{
				var col:uint = pixels.getPixel(w,h);
				r += col >> 16 & 0xFF;
				g += col >> 8 & 0xFF;
				b += col & 0xFF;
			}
		}
		var pixelCount:int = pixels.width * pixels.height;
		r = Math.round(r/pixelCount) << 16;
		g = Math.round(g/pixelCount) << 8;
	 	b = Math.round(b/pixelCount);
		
		return r | g | b;
	}
}

}


package com.thingsiam.color {

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
}

}


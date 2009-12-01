package com.thingsiam.animation
{	
	import flash.display.BitmapData;
	import flash.geom.Point;
/*
Used for pre-calculating a sequence of noise so you can animate effects in real-time
Makes it easy to cause a script timeout, so be careful how long a sequence you make
*/
	
	public class NoiseSeries
	{
		private var _series:Array;
		
		public function NoiseSeries()
		{
			_series = new Array;
		}
		
		public function generateSeries(w:Number, h:Number, length:uint, noiseX:Number=0, noiseY:Number=0, vx:Number=1, vy:Number=1, numOctaves:uint=3, randomSeed:uint=1, stitch:Boolean=false, fractalNoise:Boolean=false, channelOptions:uint=7, grayScale:Boolean=true  ):void
		{
			var bmd:BitmapData = new BitmapData( w, h, false );
			
			for( var i:uint = 0; i < length; i++ )
			{
				noiseX += vx;
				noiseY += vy;
				var offsets:Array = [new Point(noiseX, noiseY), new Point(noiseX*2, noiseY*2), new Point(noiseX*3,noiseY*3)];
				bmd.perlinNoise( bmd.width, bmd.height, numOctaves, randomSeed, stitch, fractalNoise, channelOptions, grayScale, offsets );
				_series.push(bmd.clone());
			}
		}
		
		public function getNoise( index:uint ):BitmapData
		{
			return _series[index];
		}

	}
}
package com.thingsiam.animation {

import flash.display.Sprite;
import com.thingsiam.math.Vector3D;

public class Particle extends Sprite {
	
	protected var _pos:Vector3D, _vel:Vector3D;
	protected static var _lifespan:int = 90;
	protected var _life:int = _lifespan;
	
	public function Particle( _x:Number = 0, _y:Number = 0 )
	{
		super();
		
		graphics.beginFill( 0xFFFFFF, 1.0 );
		graphics.drawCircle( 0, 0, 4 );
		graphics.endFill();
		
		_pos = new Vector3D( _x, _y );
		_vel = Vector3D.random2DVector();
		_vel.multiply(5);
	}
	
	public function update():void
	{
		_pos.add(_vel);
		x = _pos.x;
		y = _pos.y;
		
		_life--;
	}
	
	public function isDead():Boolean
	{
		return _life <= 0;
	}
	
	//
	// BASIC STEERING BEHAVIORS
	//
	
	public function seek( target:Vector3D, force:Number=0.1 ):void
	{
		var steering:Vector3D = Vector3D.sub( target, _pos );
		steering.multiply(force);
		_vel.add( steering );
		
		steering = null;
	}
	
	public function avoid( obstacle:Vector3D, force:Number=0.1 ):void
	{
		var steering:Vector3D = Vector3D.sub( _pos, obstacle );
		steering.multiply(force);
		_vel.add( steering );
		
		steering = null;
	}
	
	//
	// GETTERS AND SETTERS
	//
	
	public function get pos():Vector3D{
		return _pos;
	}
	
	public function get vel():Vector3D{
		return _vel;
	}
	
}

}


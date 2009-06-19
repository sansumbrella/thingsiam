package com.thingsiam.animation {

import com.thingsiam.math.Numbers;

public class Integrator extends Object {
	
	public var target:Number;
	public var value:Number;
	public var	vel:Number = 0,
				vmax:Number = 8,
				amax:Number = 2;
	public var	attraction:Number = 0.3,
				damping:Number = 0.52;
	private var minStep:Number = 0.01;
	
	public function Integrator( value:Number = 0, target:Number = 0 )
	{
		super();
		
		this.value = value;
		this.target = target;
	}
	
	public function update():void
	{
		vel += Numbers.limit( ( target - value )*attraction, amax );
		vel = Numbers.limit( vel, vmax );
		value += vel;
		vel *= damping;
		
		if( !isChanging ) value = target;
	}
	
	public function get isChanging():Boolean{
		return ( Math.abs(vel) > minStep || Math.abs(target - value) > minStep );
	}
	
}

}
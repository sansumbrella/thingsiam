package com.thingsiam.animation {

import com.thingsiam.math.Numbers;

public class Integrator extends Object {
	
	public var target:Number;
	public var value:Number;
	public var vel, vmax:Number;
	public var attraction:Number;
	private var minStep:Number = 0.01;
	
	public function Integrator( value:Number = 0, target:Number = 0, vmax:Number = 5, minStep:Number = 0.01, attraction:Number = 0.5 )
	{
		super();
		
		this.value = value;
		this.target = target;
		this.vmax = vmax;
		this.attraction = attraction;
		vel = 0;
		this.minStep = minStep;
	}
	
	public function update():void
	{
		vel = Numbers.limit( ( target - value )*attraction, vmax );
		value += vel;
		
		if( !isChanging ) value = target;
	}
	
	public function get isChanging():Boolean{
		return ( Math.abs(vel) > minStep || Math.abs(target - value) > minStep );
	}
	
}

}
package com.thingsiam.animation {

import com.thingsiam.math.Numbers;
import flash.utils.Timer;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.TimerEvent;

public class Integrator extends EventDispatcher {
	
	/**
	*	Integrator transitions between two values	
	*	It now automatically updates itself using a Timer
	*	Just listen for the UPDATE events
	*/
	
	public static const UPDATE:String = "integratorUpdate";
	
	private var	_target:Number;
	private var	_value:Number;
	private var _timer:Timer;
	public var	vel:Number = 0;
	public var	attraction:Number = 0.2;
	private var minStep:Number = 0.01;
	
	public function Integrator( value:Number = 0, target:Number = 0 )
	{
		super();
		
		_value = value;
		_target = target;
		
		_timer = new Timer(20);	// 50fps
		restart();
	}
	
	private function update(e:Event):void
	{
		if( isChanging )
		{
			vel = ( target - value )*attraction;
			value += vel;
		} else {
			value = target;
			_timer.reset();
			_timer.removeEventListener( TimerEvent.TIMER, update );
		}
		
		dispatchEvent( new Event(UPDATE) );
	}
	
	public function get isChanging():Boolean{
		return ( Math.abs(vel) > minStep || Math.abs(target - value) > minStep );
	}
	
	public function get target():Number{
		return _target;
	}
	
	public function get value():Number{
		return _value;
	}
	
	public function set target(num:Number):void {
		_target = num;
		restart();
	}
	
	public function set value(val:Number):void {
		_value = val;
		restart();
	}
	
	private function restart():void
	{
		if( _target != _value )
		{
			_timer.addEventListener( TimerEvent.TIMER, update );
			_timer.start();
		}
	}
	
}

}
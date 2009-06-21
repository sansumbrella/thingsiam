package com.thingsiam.animation {

import flash.display.Sprite;

public class ParticleSystem extends Sprite {
	
	protected var _particles:Array;
	
	public function ParticleSystem()
	{
		super();
		init();
	}
	
	private function init():void
	{
		_particles = new Array();
	}
	
	public function add( p:Particle ):void
	{
		_particles.push(p);
		addChild(p);
	}
	
	public function update():void
	{
		for( var i:int=_particles.length-1; i >= 0; i-- )
		{
			_particles[i].update();
			if( _particles[i].isDead() )
			{
				removeChild(_particles.splice( i, 1 )[0]);
			}
		}
	}
	
}

}


package com.thingsiam.animation {

import com.thingsiam.math.Vector3D;

public class Flock extends ParticleSystem {
	
	public function Flock()
	{
		super();
	}
	
	override public function update():void
	{
		super.update();
		for each( var b:Boid in _particles )
		{
			b.flock( _particles );
		}
	}
	
}

}


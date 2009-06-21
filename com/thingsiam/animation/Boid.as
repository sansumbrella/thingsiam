package com.thingsiam.animation {

import com.thingsiam.math.Vector3D;

public class Boid extends Particle {
	
	private var _neighborhood:Number = 100*100;
	private var _personalSpace:Number = 14*14;
	private var _damping:Number = 0.8;
	
	public function Boid()
	{
		super();
	}
	
	public function flock( group:Array ):void
	{
		var targetCenter:Vector3D = new Vector3D();
		var numTargetInfluences:int = 0;
		
		var crowdCenter:Vector3D = new Vector3D();
		var numCrowdInfluences:int = 0;
		
		var heading:Vector3D = new Vector3D();
		var numHeadingInfluences:int = 0;
		
		for each( var b:Boid in group )
		{
			if( Vector3D.dist2( _pos, b.pos ) < _neighborhood )
			{
				targetCenter.add( b.pos );
				numTargetInfluences++;
				
				heading.add( b.vel );
				numHeadingInfluences++;
				
				if( Vector3D.dist2( _pos, b.pos ) < _personalSpace )
				{
					crowdCenter.add( b.pos );
					numCrowdInfluences++;
				}
			}
		}
		
		targetCenter.divide( numTargetInfluences );
		seek( targetCenter, 0.1 );
		
		crowdCenter.divide( numCrowdInfluences );
		avoid( crowdCenter, 0.3 );
		
		heading.divide( numHeadingInfluences );
		heading = Vector3D.sub( heading, vel );
		heading.multiply(0.1);
		vel.add( heading );
		
		var randomVector:Vector3D = Vector3D.random2DVector();
		randomVector.multiply(0.01);
		vel.add( randomVector );
	}
	
	override public function update():void
	{
		super.update();
		vel.multiply(_damping);
	}
	
}

}


package examples {

import flash.display.Sprite;
import com.thingsiam.functions.ConditionalCaller;

[SWF(width=640, height=360, backgroundColor=0xFFFFFF, frameRate=30)]

public class FunctionTest extends Sprite {
	
	/**
	*	@author David Wicks
	*	Just a test to make sure the ConditionalCaller is written properly
	*	Not very exciting, but demonstrates the ability to call a function after contingencies are met
	*	by encapsulating the logic for checking that all requirements are met
	*/
	
	private var _caller:ConditionalCaller;
	private const LOAD_COMPLETE:String="loadComplete";
	private const ANIMATION_FINISHED:String="animationFinished";
	
	public function FunctionTest()
	{
		super();
		_caller = new ConditionalCaller( metRequirements );
		_caller.addRequirement( LOAD_COMPLETE );
		_caller.addRequirement( ANIMATION_FINISHED );
		
		_caller.meetRequirement( ANIMATION_FINISHED );
		_caller.meetRequirement( LOAD_COMPLETE );
	}
	
	private function metRequirements():void
	{
		trace("FunctionTest::metRequirements()");
	}
}

}


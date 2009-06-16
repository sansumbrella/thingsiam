package com.thingsiam.display {

public interface IProgressIndicator {
	function displayProgress(ratio:Number):void;
	function show():void;
	function hide(onComplete:Function):void;
}

}


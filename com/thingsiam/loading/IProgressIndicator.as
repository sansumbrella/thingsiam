package com.thingsiam.loading {

public interface IProgressIndicator {
	function displayProgress(ratio:Number):void;
	function show():void;
	function hide():void;
}

}


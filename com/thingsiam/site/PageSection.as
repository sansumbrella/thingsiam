package com.thingsiam.site {

import flash.display.Sprite;

public class PageSection extends Sprite {
	
	public function PageSection()
	{
		super();
	}
	
	public function show():void
	{
		handleShown();
	}
	
	public function hide():void
	{
		handleHidden();
	}
	
	protected function handleShown():void
	{
		dispatchEvent();
	}
	
	protected function handleHidden():void
	{
		
	}
}

}


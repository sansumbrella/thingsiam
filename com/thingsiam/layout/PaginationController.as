package com.thingsiam.layout {

import flash.display.Sprite;
import flash.events.Event;

import com.thingsiam.display.BasicButton;

public class PaginationController extends Sprite {
	
	protected var 	_paginator		:Paginator;
	
	public function PaginationController( paginator:Paginator )
	{
		super();
		_paginator = paginator;
		init();
	}
	
	private function init():void
	{
		_paginator.addEventListener( Paginator.RESIZE, handleResize, false, 0, true );
		_paginator.addEventListener( Paginator.TURN, handleTurn, false, 0, true );
	}
	
	private function handleResize(e:Event):void
	{
		rebuildView();
	}
	
	private function handleTurn(e:Event):void
	{
		updateView();
		animateTurn();
	}
	
	protected function handleNext(e:Event):void
	{
		_paginator.next();
	}
	
	protected function handlePrevious(e:Event):void
	{
		_paginator.previous();
	}
	
	protected function handleIndex(e:Event):void
	{
		_paginator.requestPage((e.target as BasicButton).id);
	}
	
	protected function updateView():void
	{
		
	}
	
	protected function animateTurn():void
	{
		
	}
	
	protected function rebuildView():void
	{
		
	}
	
}

}


package com.thingsiam.layout {

import com.thingsiam.display.BasicButton;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.MouseEvent;

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
		_paginator.addEventListener( Paginator.SIZE_CHANGE, handleResize, false, 0, true );
		_paginator.addEventListener( Paginator.PAGECOUNT_CHANGE, handleResize, false, 0, true );
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
	
	//
	//	Add control views to the controller
	//
	
	public function addNextButton(e:EventDispatcher):void
	{
		e.addEventListener( MouseEvent.CLICK, handleNext, false, 0, true );
	}
	
	public function addPreviousButton(e:EventDispatcher):void
	{
		e.addEventListener( MouseEvent.CLICK, handlePrevious, false, 0, true );
	}
	
	// remove controls
	
	public function removeNextButton(e:EventDispatcher):void
	{
		e.removeEventListener( MouseEvent.CLICK, handleNext );
	}
	
	public function removePreviousButton(e:EventDispatcher):void
	{
		e.removeEventListener( MouseEvent.CLICK, handlePrevious );
	}
	
	//
	//	To be overridden by subclasses
	//
	
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


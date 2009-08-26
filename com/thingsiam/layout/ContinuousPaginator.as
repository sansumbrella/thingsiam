package com.thingsiam.layout {

import com.thingsiam.animation.Integrator;

import flash.events.Event;
import flash.geom.Rectangle;

public class ContinuousPaginator extends Paginator {
	
	/**
	*	Lays out pages horizontally
	*	Bolts on a RowArray to the existing Paginator and adds scrolling navigation functions
	*	May do rows/grids eventually, but I'm on a deadline right now
	*/
	
	private var _integrator:Integrator;
	private var _pageRow:RowArray;
	private var _screen:Rectangle;
	
	public static const SCROLL:String = "paginatorScroll";
	public static const SCROLL_COMPLETE:String = "paginatorScrollComplete";
	private var _scrollAttraction:Number = 0.18;
	private var _snapAttraction:Number = 0.12;
	
	public function ContinuousPaginator(layout:Class, args:Object)
	{
		init();
		super( layout, args);
	}
	
	private function init():void
	{
		_integrator = new Integrator(0,0);
		_integrator.minStep = 1;
		_integrator.addEventListener( Integrator.UPDATE, handleUpdate, false, 0, true );
		_integrator.addEventListener( Integrator.COMPLETE, handleComplete, false, 0, true );
		
		_pageRow = new RowArray({margin:10});
		_pageRow.addEventListener( LayoutEvent.RESIZE, handlePageResize );
		_screen = new Rectangle( 0, 0, 960, 600 );
		
		addChild(_pageRow);
	}
	
	private function handlePageResize(e:LayoutEvent):void
	{
		if( !_integrator.isChanging )
		{	//center if locked on a page
			_pageRow.x = _integrator.target = _integrator.value = -_currentPage.x - _currentPage.width/2;	
		} else
		{
			_integrator.target = -_currentPage.x - _currentPage.width/2;
		}
	}
	
	private function handleComplete(e:Event):void
	{
		dispatchEvent( new Event(SCROLL_COMPLETE) );
	}
	
	private function handleUpdate(e:Event):void
	{
		_pageRow.x = _integrator.value;
		dispatchEvent( new Event(SCROLL));
	}
	
	override public function next():void
	{
		super.next();
		_integrator.attraction = _scrollAttraction;
	}
	
	override public function previous():void
	{
		super.previous();
		_integrator.attraction = _scrollAttraction;
	}
	
	public function scrollTo( page:* ):void
	{
		for( var i:int=0; i != _pages.length; i++ )
		{
			if( _pages[i] == page )
			{
				setPage(i);
				return;
			}
		}
	}
	
	override protected function setPage(id:int):void
	{
		_currentPage = _pages[id];
		_currentIndex = id;
		//center on the target page
		_integrator.addEventListener( Integrator.COMPLETE, handleTurnComplete );
		_integrator.target = -_currentPage.x - _currentPage.width/2;
	}
	
	private function handleTurnComplete(e:Event):void
	{
		_integrator.removeEventListener( Integrator.COMPLETE, handleTurnComplete );
		dispatchEvent( new Event(TURN) );
	}
	
	override protected function addPage():void
	{
		super.addPage();
		_pageRow.push(lastPage);
	}
	
	override public function dump():void
	{
		_pageRow.dump();
		super.dump();
	}
	
	public function setPosition( pos:Number, snap:Boolean=false ):void
	{
		/*_currentIndex = -1;*/
		_integrator.target = -pos*(lastPage.x);
		_integrator.attraction = _scrollAttraction;
		
		if( snap )
		{	//slide to the nearest page
			_integrator.attraction = _snapAttraction;
			var id:Number = 0;
			var dist:Number = Infinity;
			for( var i:int=0; i != _pages.length; i++ )
			{
				var dist2:Number = Math.abs(_pages[i].x + _integrator.target);
				if( dist2 < dist )
				{
					dist = dist2;
					id = i;
				}
			}
			
			requestPage(id);
		}
	}
	
	public function get value():Number{
		//normalized position value
		return -_integrator.value/(lastPage.x);
	}
	
	private function get lastPage():LayoutArray
	{
		return _pages[_pages.length-1];
	}
	
}

}


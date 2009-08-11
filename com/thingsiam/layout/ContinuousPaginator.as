package com.thingsiam.layout {

import flash.display.Sprite;
import flash.events.Event;
import flash.geom.Rectangle;

import com.thingsiam.animation.Integrator;

public class ContinuousPaginator extends Paginator {
	
	/**
	*	Lays out pages horizontally
	*	Bolts on a RowArray to the existing Paginator and adds scrolling navigation functions
	*	Will do rows/grids eventually, but I'm on a deadline right now
	*/
	
	private var _integrator:Integrator;
	private var _pageRow:RowArray;
	private var _screen:Rectangle;
	
	public static const SCROLL:String = "paginatorScroll";
	private var _scrollAttraction:Number = 0.15;
	private var _snapAttraction:Number = 0.08;
	
	public function ContinuousPaginator(args:Object)
	{
		init();
		super(args);
	}
	
	private function init():void
	{
		_integrator = new Integrator(0,0);
		_integrator.addEventListener( Integrator.UPDATE, handleUpdate, false, 0, true );
		
		_pageRow = new RowArray({margin:100});
		_screen = new Rectangle( 0, 0, 960, 600 );
		
		addChild(_pageRow);
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
	
	override protected function setPage(id:int):void
	{
		_currentPage = _pages[id];
		_currentIndex = id;
		//move towards page
		_integrator.target = -_currentPage.x;
		//handle this event to animate the page change
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
			
			setPage(id);
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

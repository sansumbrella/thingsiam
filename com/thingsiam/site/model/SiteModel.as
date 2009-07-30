package com.thingsiam.site.model {

import flash.events.Event;
import flash.events.EventDispatcher;
import flash.net.URLRequest;
import flash.net.navigateToURL;

public class SiteModel extends EventDispatcher {
	
	private var _pages:Array;
	public static var _instance:SiteModel;
	public static const PAGE_404:String = "404";
	
	private var _currentSection:String;
	private var _currentPage:String;
	private var _launchFunction:Function;
	
	public function SiteModel( l:Lock )
	{
		super();
		init();
	}
	
	private function init():void
	{
		_pages = new Array();
		_launchFunction = defaultLaunchFunction;
	}
	
	public static function get instance():SiteModel{
		if(!_instance) _instance = new SiteModel(new Lock());
		return _instance;
	}
	
	public function initWithArray( pages:Array ):void
	{	//copy the page url/browser-path mapping
		_pages = pages.slice();
	}
	
	public function initWithXML( path:String ):void
	{
		throw new Error("Init with XML has not yet been implemented. Try initWithArray instead.");
	}
	
	/*
		Changing the state of the model
		If it's a change from outside, that may have already been heard by the site
		If it's an internal change, the site needs to be notified
	*/
	
	public function setStateQuietly( state:String ):void
	{
		//should only be used when the application is already at the desired state
		//(ie never, except when something else sets the application state, like SWFAddress )
		_currentPage = pageFrom(state);
		_currentSection = sectionFrom(state);
	}
	
	public function setState( page:String, section:String="" ):void
	{
		if( _currentPage == page && _currentSection == section )
		{
			return;
		}
		_currentPage = page;
		_currentSection = section;
		
		dispatchEvent(new Event(Event.CHANGE));
	}
	
	public function setSection( section:String="" ):void
	{	//so sub-pages can still navigate through the main model
		if( _currentSection == section )
		{
			return;
		}
		_currentSection = section;
		dispatchEvent(new Event(Event.CHANGE));
	}
	
	public function launchURL( url:String ):void
	{
		_launchFunction(url);
	}
	
	private function defaultLaunchFunction(url:String):void
	{
		navigateToURL( new URLRequest(url), "_self" );
	}
	
	/*
		Current page and section
	*/
	
	public function get page():String{
		return _currentPage;
	}
	
	public function get section():String{
		return _currentSection;
	}
	
	public function get address():String{
		return addressFrom(_currentPage, _currentSection);
	}
	
	/*
		Mapping functions for converting asset paths into browser paths
	*/
	
	public function pageFrom( address:String ):String
	{
		//The page is the first section of the hash
		address = address.slice(0, address.indexOf("/",1)+1);
		for each( var p:SWFAddressPageModel in _pages )
		{
			if( p.address == address )
			{
				return p.url;
			}
		}
		return PAGE_404;
	}
	
	public function sectionFrom( address:String ):String
	{
		//The section is everything after the page
		return address.slice( address.indexOf("/",1)+1, address.length );
	}
	
	public function addressFrom( page:String, section:String ):String
	{
		for each( var p:SWFAddressPageModel in _pages )
		{
			if( p.url == page )
			{
				return (p.address + section);
			}
		}
		return "";
	}
	
	public function set launchFunction(value:Function):void {
		_launchFunction = value;
	}
	
}

}

class Lock{}
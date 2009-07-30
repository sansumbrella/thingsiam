package com.thingsiam.site.data {

import flash.display.Loader;
import flash.net.URLRequest;

public class PageRequest extends Loader {
	
	private var _pageName:String;
	private var _basePath:String;
	
	public function PageRequest( _pageName:String, _basePath:String="" )
	{
		super();
		this._pageName = _pageName;
		this._basePath = _basePath;
	}
	
	public function get pageName():String{
		return _pageName;
	}
	
	public function loadPage():void
	{
		load( new URLRequest( _basePath + _pageName ) );
	}
}

}


package com.thingsiam.site.model {

public class SWFAddressPageModel extends Object {
	
	private var _address:String;
	private var _url:String;
	
	public function SWFAddressPageModel( url:String, address:String )
	{
		super();
		_address = address;
		_url = url;
	}
	
	public function get address():String
	{
		//value in SWFAddress terms
		return _address;
	}
	
	public function get url():String
	{
		return _url;
	}
	
}

}


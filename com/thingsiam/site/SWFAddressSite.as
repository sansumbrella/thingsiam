package com.thingsiam.site {

import com.thingsiam.site.model.SWFAddressPageModel;
import com.asual.swfaddress.SWFAddress;
import com.asual.swfaddress.SWFAddressEvent;

public class SWFAddressSite extends AbstractSite {
	
	/**
	*	Communicates with SWFAddress to receive load events and set the address after navigation
	*	I hope the name and intent make it clear that you need SWFAddress, available from:
	*	http://www.asual.com/swfaddress/
	*/
	
	protected var _pages:Array;
	private var _successfulPage:String;
	
	public function SWFAddressSite()
	{
		super();
		init();
	}
	
	private function init():void
	{
		_pages = new Array();
		addEventListener( SiteEvent.TRANSITION_END, handleNavigationComplete, false, 0, true );
		SWFAddress.addEventListener(SWFAddressEvent.CHANGE, handleSWFAddressChange, false, 0, true );
	}	
	
	private function handleSWFAddressChange(e:SWFAddressEvent):void
	{
		//map current hash to list of pages and subnav items
		super.navigateTo( pageFrom(e.value), sectionFrom(e.value) );
	}
	
	override public function navigateTo( page:String, section:String="" ):void
	{
		SWFAddress.setValue( addressFrom(page, section) );
	}
	
	private function pageFrom( address:String ):String
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
	
	private function sectionFrom( address:String ):String
	{
		//The section is everything after the page
		return address.slice( address.indexOf("/",1)+1, address.length );
	}
	
	private function addressFrom( page:String, section:String ):String
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
	
	private function handleNavigationComplete(e:SiteEvent):void
	{
		// send e.pageName to SWFAddress
	}
	
	
}

}
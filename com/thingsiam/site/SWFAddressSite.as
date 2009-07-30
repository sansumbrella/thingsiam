package com.thingsiam.site {

import com.thingsiam.site.model.SWFAddressPageModel;
import com.thingsiam.site.model.SiteModel;
import com.asual.swfaddress.SWFAddress;
import com.asual.swfaddress.SWFAddressEvent;
import flash.events.Event;

public class SWFAddressSite extends AbstractSite {
	
	/**
	*	Communicates with SWFAddress to receive load events and set the address after navigation
	*	I hope the name and intent make it clear that you need SWFAddress, available from:
	*	http://www.asual.com/swfaddress/
	*/
	
	public function SWFAddressSite()
	{
		super();
		init();
	}
	
	private function init():void
	{
		addEventListener( SiteEvent.TRANSITION_END, handleNavigationComplete, false, 0, true );
		SWFAddress.addEventListener(SWFAddressEvent.CHANGE, handleSWFAddressChange, false, 0, true );
		model.launchFunction = this.launchURL;
	}
	
	override protected function handleModelChange(e:Event):void
	{
		//change SWFAddress to reflect model value
		changeSWFAddress();
	}
	
	private function launchURL( url:String ):void
	{
		SWFAddress.href(url);
	}
	
	private function handleSWFAddressChange(e:SWFAddressEvent):void
	{	
		//if the state came from outside, we need to update the model
		model.setStateQuietly( e.value );
		//display the state in our view
		navigateTo( model.page, model.section );
	}
	
	private function changeSWFAddress():void
	{
		SWFAddress.setValue( SiteModel.instance.address );
	}
	
	private function handleNavigationComplete(e:SiteEvent):void
	{
		// send e.pageName to SWFAddress
	}
	
	
}

}
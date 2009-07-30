package com.thingsiam.site.controllers {

import flash.display.Sprite;
import com.thingsiam.site.model.SiteModel;
import com.thingsiam.site.AbstractSite;

public class NavigationController extends Sprite {
	
	public function NavigationController()
	{
		//set the model state with navigation events
		super();
	}
	
	/*
		Convenience functions
	*/
	public function get model():SiteModel{
		return SiteModel.instance;
	}
}

}


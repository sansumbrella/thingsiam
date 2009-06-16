package examples {

import flash.display.Sprite;
import flash.display.DisplayObject;
import flash.display.Loader;
import com.thingsiam.loading.BasicPreloader;

import flash.net.URLRequest;
import flash.net.navigateToURL;

import flash.events.Event;
import flash.events.MouseEvent;

import flash.text.TextField;

[SWF(width=1024, height=683, backgroundColor=0x999999, frameRate=30)]

public class ImageLoading extends Sprite {
	
	
	private var _loader:Loader;
	private var _progressBar:Sprite;
	private var _preloader:BasicPreloader;
	private var _imageURL:String = "http://farm4.static.flickr.com/3539/3630866375_3a3be24ffc_b.jpg";
	private var _imagePage:String = "http://www.flickr.com/photos/sansumbrella/3630866375/"; //since it's hosted by flickr
	
	public function ImageLoading()
	{
		super();
		init();
	}
	
	private function init():void
	{
		_preloader = new BasicPreloader();
		//store a reference to the preloader view as a DisplayObject so we aren't repeatedly casting its type
		_progressBar = _preloader.view as Sprite;
		_loader = new Loader;
		
		_progressBar.x = 512 - _progressBar.width/2;
		_progressBar.y = 300;
		
		addChild( _loader );
		addChild( _progressBar );	//note that it's on top of the image
		
		_preloader.observe(_loader.contentLoaderInfo);
		_loader.load( new URLRequest(_imageURL) );
		
		buttonMode = true;
		_loader.addEventListener( MouseEvent.CLICK, handleClick );
	}
	
	private function handleClick( e:Event ):void
	{	//go to the flickr photo page
		navigateToURL(new URLRequest(_imagePage))
	}
	
}

}


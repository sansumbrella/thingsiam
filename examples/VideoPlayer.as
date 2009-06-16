package examples {

import flash.display.Sprite;
import flash.display.Shape;

import com.thingsiam.video.SimpleVideo;
import com.thingsiam.display.BasicButton;
import com.thingsiam.layout.ScreenModel;

import flash.events.Event;
import flash.events.DataEvent;
import flash.events.MouseEvent;

[SWF(width=640, height=360, backgroundColor=0xFFFFFF, frameRate=30)]

public class VideoPlayer extends Sprite {
	
	private var _video:SimpleVideo;
	private var _screen:ScreenModel;
	private var _controlMC:BasicButton;
	private var _playheadMC:Shape;
	private var _loadIndicatorMC:Shape;
	
	private var w:Number = 640, h:Number = 360;
	
	public function VideoPlayer()
	{
		super();
		init();
	}
	
	private function init():void
	{
		_video = new SimpleVideo(w, h);
		addChild(_video);
		_video.connect();
		_video.play("http://thingsiam.com/projects/personal/animation/hands_small.flv");
		
		_video.addEventListener( SimpleVideo.PROGRESS_UPDATE, handleProgress, false, 0, true );
		_video.addEventListener( SimpleVideo.LOAD_UPDATE, handleLoading, false, 0, true );
		_video.addEventListener( SimpleVideo.END, handleComplete, false, 0, true );
		
		_screen = new ScreenModel( stage, w, h );
		_screen.addEventListener( Event.CHANGE, handleScreenChange, false, 0, true );
		
		createControls();
	}
	
	private function createControls():void
	{
		_controlMC = new BasicButton();
		
		_playheadMC = new Shape();
		_playheadMC.graphics.beginFill( 0xFF0000, 1 );
		_playheadMC.graphics.drawRect( 0, 1, 2, h*0.05-1 );
		
		var border:Shape = new Shape();
		border.graphics.lineStyle( 1, 0xFFFFFF, 1 );
		border.graphics.drawRect( 0, 0, w-1, h*0.05 );
		
		_loadIndicatorMC = new Shape();
		_loadIndicatorMC.graphics.beginFill( 0x333333, 0.25 );
		_loadIndicatorMC.graphics.drawRect( 0, 1, w-1, h*0.05 );
		
		_controlMC.addChild(border);
		_controlMC.addChild( _loadIndicatorMC );
		_controlMC.addChild( _playheadMC );
		
		_controlMC.y = h-_controlMC.height;
		_controlMC.addEventListener( MouseEvent.MOUSE_DOWN, startScrubbing, false, 0, true );
		
		addChild(_controlMC);
	}
	
	private function startScrubbing( e:Event ):void
	{
		handleSeek( e );
		stage.addEventListener( MouseEvent.MOUSE_MOVE, handleSeek, false, 0, true );
		stage.addEventListener( MouseEvent.MOUSE_UP, stopScrubbing, false, 0, true );
		stage.addEventListener( Event.MOUSE_LEAVE, stopScrubbing, false, 0, true );
	}
	
	private function stopScrubbing( e:Event ):void
	{
		stage.removeEventListener( MouseEvent.MOUSE_MOVE, handleSeek );
		stage.removeEventListener( MouseEvent.MOUSE_UP, stopScrubbing );
		stage.removeEventListener( Event.MOUSE_LEAVE, stopScrubbing );
	}
	
	private function handleSeek( e:Event ):void
	{
		_video.seek( _controlMC.mouseX/_controlMC.width ); //just pass in a normalized position
	}
	
	private function handleProgress( e:DataEvent ):void
	{
		var pos:Number = Number(e.data);
		_playheadMC.x = pos*(_controlMC.width-_playheadMC.width/2);
	}
	
	private function handleLoading( e:DataEvent ):void
	{
		_loadIndicatorMC.scaleX = Number(e.data);
	}
	
	private function handleComplete( e:Event ):void
	{
		_video.rewind();
		_video.resume();
	}
	
	private function handleScreenChange( e:Event ):void
	{
		_controlMC.y = _screen.bottom - _controlMC.height;
		_controlMC.x = _screen.centerX - _controlMC.width/2;
		_video.resize( _screen.width, _screen.height );
	}
}

}


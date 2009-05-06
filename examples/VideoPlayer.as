package {

import flash.display.Sprite;
import flash.display.Shape;

import com.thingsiam.video.SimpleVideo;
import com.thingsiam.display.BasicButton;
import com.thingsiam.layout.ScreenModel;

import flash.events.Event;
import flash.events.DataEvent;
import flash.events.MouseEvent;

public class VideoPlayer extends Sprite {
	
	private var video:SimpleVideo;
	private var screen:ScreenModel;
	private var controlMC:BasicButton;
	private var playheadMC:Shape;
	private var loadIndicatorMC:Shape;
	
	private var w:Number = 640, h:Number = 360;
	
	public function VideoPlayer()
	{
		super();
		init();
	}
	
	private function init():void
	{
		video = new SimpleVideo(w, h);
		addChild(video);
		video.connect();
		video.play("http://thingsiam.com/projects/personal/animation/hands_small.flv");
		
		video.addEventListener( SimpleVideo.PROGRESS_UPDATE, handleProgress, false, 0, true );
		video.addEventListener( SimpleVideo.LOAD_UPDATE, handleLoading, false, 0, true );
		video.addEventListener( SimpleVideo.END, handleComplete, false, 0, true );
		
		screen = new ScreenModel( stage, w, h );
		screen.addEventListener( Event.CHANGE, handleScreenChange, false, 0, true );
		
		createControls();
	}
	
	private function createControls():void
	{
		controlMC = new BasicButton();
		
		playheadMC = new Shape();
		playheadMC.graphics.beginFill( 0xFF0000, 1 );
		playheadMC.graphics.drawRect( 0, 1, 2, h*0.05-1 );
		
		var border:Shape = new Shape();
		border.graphics.lineStyle( 1, 0xFFFFFF, 1 );
		border.graphics.drawRect( 0, 0, w-1, h*0.05 );
		
		loadIndicatorMC = new Shape();
		loadIndicatorMC.graphics.beginFill( 0x333333, 0.25 );
		loadIndicatorMC.graphics.drawRect( 0, 1, w-1, h*0.05 );
		
		controlMC.addChild(border);
		controlMC.addChild( loadIndicatorMC );
		controlMC.addChild( playheadMC );
		
		controlMC.y = h-controlMC.height;
		controlMC.addEventListener( MouseEvent.MOUSE_DOWN, startScrubbing, false, 0, true );
		
		addChild(controlMC);
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
		video.seek( controlMC.mouseX/controlMC.width ); //just pass in a normalized position
	}
	
	private function handleProgress( e:DataEvent ):void
	{
		var pos:Number = Number(e.data);
		playheadMC.x = pos*(controlMC.width-playheadMC.width/2);
	}
	
	private function handleLoading( e:DataEvent ):void
	{
		loadIndicatorMC.scaleX = Number(e.data);
	}
	
	private function handleComplete( e:Event ):void
	{
		video.rewind();
		video.resume();
	}
	
	private function handleScreenChange( e:Event ):void
	{
		controlMC.y = screen.bottom - controlMC.height;
		controlMC.x = screen.centerX - controlMC.width/2;
		video.resize( screen.width, screen.height );
	}
}

}


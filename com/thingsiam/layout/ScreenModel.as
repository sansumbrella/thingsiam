﻿package com.thingsiam.layout {	import flash.display.StageScaleMode;	import flash.display.StageAlign;	import flash.events.EventDispatcher;	import flash.events.Event;	import flash.display.Stage;	public class ScreenModel extends EventDispatcher {		private var theStage:Stage;		public var	left:Number,					right:Number,					startWidth:Number,					startHeight:Number,					top:Number,					bottom:Number,					centerX:Number,					centerY:Number,					width:Number,					height:Number;				public function ScreenModel( _stage:Stage, _w:Number = 800, _h:Number = 400 ) {			startWidth = _w;			startHeight = _h;			theStage = _stage;			theStage.scaleMode = StageScaleMode.NO_SCALE;			theStage.align = StageAlign.TOP_LEFT;						initialize();		}				public function forceResize():void{			onResize(null);		}				private function initialize():void {			left = 0;			right = startWidth;			top = 0;			bottom = startHeight;			centerX = startWidth/2;			centerY = startHeight/2;			width = right - left;			height = bottom - top;						theStage.addEventListener( Event.RESIZE, onResize );		}		private function onResize( event:Event ):void{			if( theStage.stageWidth != 0 && theStage.stageHeight != 0 )			{				left = 0;//( startWidth - theStage.stageWidth )/2				right = theStage.stageWidth; //( startWidth + theStage.stageWidth )/2;				top = 0; //( startHeight - theStage.stageHeight )/2;				bottom = theStage.stageHeight;//( startHeight + theStage.stageHeight )/2;				width = right - left;				height = bottom - top;				centerX = width/2;				centerY = height/2;				dispatchEvent( new Event( Event.CHANGE ) );			}		}			}}
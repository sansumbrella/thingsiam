package com.thingsiam.video {

import flash.net.NetConnection;
import flash.events.Event;

/*
A replacement for the NetConnection class.
Handles the onBWDone function call from rtmp servers.
_index allows the _controller to attempt multiple connections and pick the first successful one
*/

public class NetConnectionWrapper extends NetConnection {
	
	public static const BANDWIDTH:String = "ncBandwidth";
	
	private var _index:uint;
	private var _expectBWDone:Boolean;
	private var _port:String;
	private var _protocol:String;
	private var _bandwidth:Number;
	private var _latency:Number;
	private var _controller:SimpleVideo;
	
	public function NetConnectionWrapper()
	{
		super();
	}
	
	public function get index():uint{
		return _index;
	}
	
	public function set index(value:uint):void {
		_index = value;
	}
	
	public function get expectBWDone():Boolean{
		return _expectBWDone;
	}
	
	public function set expectBWDone(value:Boolean):void {
		_expectBWDone = value;
	}
	
	public function get port():String{
		return _port;
	}
	
	public function set port(value:String):void {
		_port = value;
	}
	
	public function get protocol():String{
		return _protocol;
	}
	
	public function set protocol(value:String):void {
		_protocol = value;
	}
	
	public function get bandwidth():Number{
		return _bandwidth;
	}
	
	public function get latency():Number{
		return _latency;
	}
	
	public function onBWDone(...args):void
	{
		if( _expectBWDone && !isNaN( args[0] ) )
		{
			_expectBWDone = false;
			_bandwidth = args[0];
			dispatchEvent( new Event( BANDWIDTH ) );
		}
	}
	
	public function onBWCheck( p_payload:Number ):void
	{
		return;
	}
	
	public function _onbwcheck( data:Object, ctx:Number ):Number
	{
		return ctx;
	}
	
	public function _onbwdone( latencyMS:Number, bandwidthKBPS:Number ):void
	{
		_bandwidth = bandwidthKBPS;
		_latency = latencyMS;
		dispatchEvent( new Event( BANDWIDTH ) );
	}
	
	public function get controller():SimpleVideo{
		return _controller;
	}
	
	public function set controller(value:SimpleVideo):void {
		_controller = value;
	}
	
	public function onFCSubscribe(info:Object):void
	{
		for( var item:Object in info )
			trace("NetConnectionWrapper::onFCSubscribe()", item, ":", info[item]);
	}
	
	public function onFCUnsubscribe(info:Object):void
	{
		for( var item:Object in info )
			trace("NetConnectionWrapper::onFCSubscribe()", item, ":", info[item]);
	}

}

}


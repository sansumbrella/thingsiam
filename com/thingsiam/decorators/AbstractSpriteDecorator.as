package com.thingsiam.decorators {

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.Sprite;
import flash.display.Graphics;
import flash.display.Stage;
import flash.display.LoaderInfo;

import flash.geom.Rectangle;
import flash.geom.Point;
import flash.geom.Transform;
import flash.media.SoundTransform;

import com.thingsiam.iterators.IIterator;
import com.thingsiam.iterators.ForwardIterator;

import flash.events.Event;
import flash.ui.ContextMenu;

public class AbstractSpriteDecorator extends Sprite {
	/*
	This is the kind of thing you only want to write once.
	Allows concrete decorator classes to add functionality to sprites without changing the object's core functionality.
	Proxies nearly every function/accessor/mutator available to a Sprite to the decorated object
	
	Needs to subclass Sprite so it can be used interchangeably with sprites
	Would be nice to find another way for the object to identify itself as a sprite (like an ISprite interface)
	
	Decorators are great for adding new stuff to a Sprite (like scrollbars, tooltips, or flying stuff)
	The best part about it is being able to add and remove decorators at runtime, so you can change things live
	Not good for manipulating existing Sprite children (which I learned by implementing with the ToggleDecorator)
	*/
	protected var _decorated:Sprite;
	
	public function AbstractSpriteDecorator( _decorated:Sprite )
	{
		super();
		this._decorated = _decorated;
	}
	
	public function get decorated():Sprite{
		//just in case this is necessary for adding as a child or whatnot
		return _decorated;
	}
	
	public function get decoratedIterator():IIterator{
		var decorated:Array = new Array();
		decorated.push(_decorated);
		var i:int = 0;
		while( decorated[i] is AbstractSpriteDecorator )
		{
			decorated.push( decorated[i].decorated );
			i++;
		}
		return new ForwardIterator( decorated );
	}
	
	//=======================================================//
	//
	// EventDispatcher methods and properties
	//
	//=======================================================//
	
	override public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void
	{
		_decorated.addEventListener( type, listener, useCapture, priority, useWeakReference );
	}
	
	override public function dispatchEvent(event:Event):Boolean
	{
		return _decorated.dispatchEvent( event );
	}
	
	override public function hasEventListener(type:String):Boolean
	{
		return _decorated.hasEventListener(type);
	}
	
	override public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void
	{
		_decorated.removeEventListener( type, listener, useCapture );
	}
	
	override public function willTrigger(type:String):Boolean
	{
		return _decorated.willTrigger(type);
	}
	
	//=======================================================//
	//
	// DisplayObjectContainer methods and properties
	//
	//=======================================================//
	
	override public function addChild( child:DisplayObject ):DisplayObject
	{
		return _decorated.addChild( child );
	}
	
	override public function addChildAt(child:DisplayObject, index:int):DisplayObject
	{
		return _decorated.addChildAt( child, index );
	}
	
	override public function areInaccessibleObjectsUnderPoint(point:Point):Boolean
	{
		return _decorated.areInaccessibleObjectsUnderPoint(point);
	}
	
	override public function contains(child:DisplayObject):Boolean
	{
		return _decorated.contains(child);
	}
	
	override public function getChildAt( index:int ):DisplayObject
	{
		return _decorated.getChildAt(index);
	}
	
	override public function getChildByName(name:String):DisplayObject
	{
		return _decorated.getChildByName(name);
	}
	
	override public function getChildIndex(child:DisplayObject):int
	{
		return _decorated.getChildIndex(child);
	}
	
	override public function getObjectsUnderPoint(point:Point):Array
	{
		return _decorated.getObjectsUnderPoint(point);
	}
	
	override public function removeChild(child:DisplayObject):DisplayObject
	{
		return _decorated.removeChild(child);
	}
	
	override public function removeChildAt(index:int):DisplayObject
	{
		return _decorated.removeChildAt(index);
	}
	
	override public function setChildIndex(child:DisplayObject, index:int):void
	{
		_decorated.setChildIndex( child, index );
	}
	
	override public function swapChildren(child1:DisplayObject, child2:DisplayObject):void
	{
		_decorated.swapChildren( child1, child2 );
	}
	
	override public function swapChildrenAt(index1:int, index2:int):void
	{
		_decorated.swapChildrenAt( index1, index2 );
	}
	
	override public function get mouseChildren():Boolean{
		return _decorated.mouseChildren;
	}
	
	override public function set mouseChildren(value:Boolean):void {
		_decorated.mouseChildren = value;
	}
	
	override public function get numChildren():int{
		return _decorated.numChildren;
	}
	
	override public function get tabChildren():Boolean{
		return _decorated.tabChildren;
	}
	
	//=======================================================//
	//
	// Sprite methods and properties
	//
	//=======================================================//
	
	override public function get buttonMode():Boolean{
		return _decorated.buttonMode;
	}
	
	override public function set buttonMode(value:Boolean):void {
		_decorated.buttonMode = value;
	}
	
	override public function get dropTarget():DisplayObject{
		return _decorated.dropTarget;
	}
	
	override public function get graphics():Graphics{
		return _decorated.graphics;
	}
	
	override public function get hitArea():Sprite{
		return _decorated.hitArea;
	}
	
	override public function set hitArea(value:Sprite):void {
		_decorated.hitArea = value;
	}
	
	override public function get soundTransform():SoundTransform{
		return _decorated.soundTransform;
	}
	
	override public function set soundTransform(value:SoundTransform):void {
		_decorated.soundTransform = value;
	}
	
	override public function get useHandCursor():Boolean{
		return _decorated.useHandCursor;
	}
	
	override public function set useHandCursor(value:Boolean):void {
		_decorated.useHandCursor = value;
	}
	
	override public function startDrag(lockCenter:Boolean = false, bounds:Rectangle = null):void
	{
		_decorated.startDrag( lockCenter, bounds );
	}
	
	override public function stopDrag():void
	{
		_decorated.stopDrag();
	}
	
	//=======================================================//
	//
	// InteractiveObject properties
	//
	//=======================================================//
	
	override public function get contextMenu():ContextMenu{
		return _decorated.contextMenu;
	}
	
	override public function set contextMenu(value:ContextMenu):void {
		_decorated.contextMenu = value;
	}
	
	override public function get doubleClickEnabled():Boolean{
		return _decorated.doubleClickEnabled;
	}
	
	override public function set doubleClickEnabled(value:Boolean):void {
		_decorated.doubleClickEnabled = value;
	}
	
	override public function set mouseEnabled(value:Boolean):void {
		_decorated.mouseEnabled = value;
	}
	
	override public function get mouseEnabled():Boolean{
		return _decorated.mouseEnabled;
	}
	
	override public function get tabEnabled():Boolean{
		return _decorated.tabEnabled;
	}
	
	override public function set tabEnabled(value:Boolean):void {
		_decorated.tabEnabled = value;
	}
	
	override public function get tabIndex():int{
		return _decorated.tabIndex;
	}
	
	override public function set tabIndex(value:int):void {
		_decorated.tabIndex = value;
	}
	
	//=======================================================//
	//
	//DisplayObject methods and properties
	//	
	//=======================================================//
	
	override public function getBounds(targetCoordinateSpace:DisplayObject):Rectangle
	{
		return _decorated.getBounds( targetCoordinateSpace );
	}
	
	override public function getRect(targetCoordinateSpace:DisplayObject):Rectangle
	{
		return _decorated.getRect(targetCoordinateSpace);
	}
	
	override public function globalToLocal(point:Point):Point
	{
		return _decorated.globalToLocal(point);
	}
	
	override public function hitTestObject(obj:DisplayObject):Boolean
	{
		return _decorated.hitTestObject(obj);
	}
	
	override public function hitTestPoint(x:Number, y:Number, shapeFlag:Boolean = false):Boolean
	{
		return _decorated.hitTestPoint(x,y,shapeFlag);
	}
	
	override public function localToGlobal(point:Point):Point
	{
		return _decorated.localToGlobal(point);
	}
	
	override public function get alpha():Number{
		return _decorated.alpha;
	}
	
	override public function set alpha(value:Number):void {
		_decorated.alpha = value;
	}
	
	override public function get blendMode():String{
		return _decorated.blendMode;
	}
	
	override public function set blendMode(value:String):void {
		_decorated.blendMode = value;
	}
	
	override public function get cacheAsBitmap():Boolean{
		return _decorated.cacheAsBitmap;
	}
	
	override public function set cacheAsBitmap(value:Boolean):void {
		_decorated.cacheAsBitmap = value;
	}
	
	override public function get filters():Array{
		return _decorated.filters;
	}
	
	override public function set filters(value:Array):void {
		_decorated.filters = value;
	}
	
	override public function get height():Number{
		return _decorated.height;
	}
	
	override public function set height(value:Number):void {
		_decorated.height = value;
	}
	
	override public function get loaderInfo():LoaderInfo{
		return _decorated.loaderInfo;
	}
	
	override public function get mask():DisplayObject{
		return _decorated.mask;
	}
	
	override public function set mask(value:DisplayObject):void {
		_decorated.mask = value;
	}
	
	override public function get mouseX():Number{
		return _decorated.mouseX;
	}
	
	override public function get mouseY():Number{
		return _decorated.mouseY;
	}
	
	override public function get name():String{
		return _decorated.name;
	}
	
	override public function set name(value:String):void {
		_decorated.name = value;
	}
	
	override public function get opaqueBackground():Object{
		return _decorated.opaqueBackground;
	}
	
	override public function set opaqueBackground(value:Object):void {
		_decorated.opaqueBackground = value;
	}
	
	override public function get parent():DisplayObjectContainer {
		return _decorated.parent;
	}
	
	override public function get root():DisplayObject{
		return _decorated.root;
	}
	
	override public function get rotation():Number {
		return _decorated.rotation;
	}
	
	override public function get scale9Grid():Rectangle{
		return _decorated.scale9Grid;
	}
	
	override public function get scaleX():Number{
		return _decorated.scaleX;
	}
	
	override public function set scaleX(value:Number):void {
		_decorated.scaleX = value;
	}
	
	override public function get scaleY():Number{
		return _decorated.scaleY;
	}
	
	override public function set scaleY(value:Number):void {
		_decorated.scaleY = value;
	}
	
	override public function get scrollRect():Rectangle{
		return _decorated.scrollRect;
	}
	
	override public function set scrollRect(value:Rectangle):void {
		_decorated.scrollRect = value;
	}
	
	override public function get stage():Stage{
		return _decorated.stage;
	}
	
	override public function get transform():Transform{
		return _decorated.transform;
	}
	
	override public function set transform(value:Transform):void {
		_decorated.transform = value;
	}
	
	override public function get visible():Boolean{
		return _decorated.visible;
	}
	
	override public function set visible(value:Boolean):void {
		_decorated.visible = value;
	}
	
	override public function get width():Number{
		return _decorated.width;
	}
	
	override public function set width(value:Number):void {
		_decorated.width = value;
	}
	
	override public function get x():Number{
		return _decorated.x;
	}
	
	override public function set x(value:Number):void {
		_decorated.x = value;
	}
	
	override public function get y():Number{
		return _decorated.y;
	}
	
	override public function set y(value:Number):void {
		_decorated.y = value;
	}
}

}


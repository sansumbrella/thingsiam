package com.thingsiam.iterators {
	
	/**
	*	@author David Wicks
	*	@since  08.05.2008
	*	
	*	Creates a set of shuffled indices for a collection and iterates through the indices.
	*/
	
	import com.thingsiam.iterators.IIterator;
	
	public class ShuffledIterator implements IIterator {
		
		private var indices:Array,
					collection:Array,
					lastIndex:int;
		
		public function ShuffledIterator( _collection:Array )
		{
			collection = _collection;
			
			shuffle();
		}
		
		public function hasNext() : Boolean
		{
			return indices.length != 0;
		}
		
		public function next() : Object
		{
			lastIndex = indices.shift();
			return collection[lastIndex];
		}
		
		public function reset() : void
		{
			shuffle();
		}
		
		public function current() : Object
		{
			return collection[lastIndex];
		}
		
		private function shuffle():void
		{
			indices = new Array();
			for( var i:int=0; i != collection.length; i++ )
			{
				indices.push(i);
			}
			
			var temp:Array = indices.splice(0,indices.length);
			while( temp.length != 0 ){
				indices.push( temp.splice( Math.floor( Math.random()*temp.length-0.001 ), 1 )  );
			}
			
		}
		
	}
	
}

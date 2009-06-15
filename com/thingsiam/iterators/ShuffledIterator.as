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
					collection:Array;
		
		public function ShuffledIterator( _collection:Array )
		{
			collection = _collection;
			indices = new Array();
			for( var i:int=0; i != collection.length; i++ )
			{
				indices.push(i);
			}
			shuffle();
		}
		
		public function hasNext() : Boolean
		{
			return indices.length != 0;
		}
		
		public function next() : Object
		{
			return collection[indices.shift()];
		}
		
		public function reset() : void
		{
			indices = new Array();
			for( var i:int=0; i != collection.length; i++ )
			{
				indices.push(i);
			}
			shuffle();
		}
		
		public function current() : Object
		{
			return collection[indices[0]];
		}
		
		private function shuffle():void
		{
			var temp:Array = indices.splice(0,indices.length);
			while( temp.length != 0 ){
				indices.push( temp.splice( Math.floor( Math.random()*temp.length-0.001 ), 1 )  );
			}
			
		}
		
	}
	
}

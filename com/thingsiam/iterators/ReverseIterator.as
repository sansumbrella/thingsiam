package com.thingsiam.iterators {
	
	/*
	*	@author David Wicks
	*	@since  08.05.2008
	*/

	public class ReverseIterator implements IIterator {
		
		private var index:uint = 0,
					collection:Array;
		
		public function ReverseIterator( _collection:Array ){
			collection = _collection;
			index = collection.length-1;
		}
		
		public function hasNext() : Boolean {
			return index >= 0;
		}
		
		public function next() : Object {
			return collection[index--];
		}
		
		public function reset() : void {
			index = collection.length-1;
		}
		
		public function current() : Object {
			return collection[index];
		}
		
	}
	
}

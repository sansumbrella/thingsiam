package com.thingsiam.iterators {
	
	/*
	*	@author David Wicks
	*	@since  08.05.2008
	*/
	
	import com.thingsiam.iterators.IIterator;
	
	public class ForwardIterator implements IIterator {
		
		private var index:uint = 0,
					collection:Array;
		
		public function ForwardIterator( _collection:Array ){
			collection = _collection;
			index = 0;
		}
		
		public function hasNext() : Boolean {
			return index < collection.length;
		}
		
		public function next() : Object {
			return collection[index++];
		}
		
		public function reset() : void {
			index = 0;
		}
		
		public function current() : Object {
			return collection[index];
		}
		
	}
	
}

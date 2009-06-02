package com.thingsiam.iterators {
	
	/*
	*	@author David Wicks
	*	@since  10.05.2008
	*/

	public class TwoWayIterator {
		
		private var collection:Array,
					index:int = 0;
		
		public function TwoWayIterator( _collection:Array ){
			collection = _collection;
			index = 0;
		}
		
		public function previous() : Object {
			if( index == 0 ) index = collection.length;
			return collection[ --index ];
		}
		
		public function current() : Object {
			return collection[ index ];
		}
		
		public function next() : Object {
			if( index == collection.length - 1 ) index = -1;
			return collection[ ++index ];
		}
		
		public function setIndex( id:int ) : Boolean {
			if( id < 0 || id >= collection.length ) return false;
			index = id;
			return collection[index];
		}
		
	}
	
}

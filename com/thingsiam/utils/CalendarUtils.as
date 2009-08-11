package com.thingsiam.utils
{
	public class CalendarUtils
	{
		/**
		 * Static functions for dealing with dates, conversions, etc
		 */
		 
		private static const _monthNames:Array = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
		
		public static function monthName( month:int, endIndex:int=0x7fffffff ):String
		{
			return (_monthNames[month] as String).substring(0, endIndex);
		} 
		
	}
}
package eu.powdermonkey.maths
{
	public class Maths 
	{
		private static var hexChars:String = "0123456789ABCDEF";
		
		/**
		 * Return a rounded number to a certain number of decimals
		 * @param n					number value
		 * @param decimals	number of desired decimals
		 * @return 					A rounded number with the specified number of decimals
		 * 
		 * Example:
		 * roundDecimal(12.55555, 2) will return 12.56
		 * roundDecimal(12.55555, 0) will return 13
		 * roundDecimal(12.55555, -1) will return 10
		 */
		public static function roundDecimal(n:Number, decimals:int=0):Number 
		{
			var div:Number = Math.pow(10,decimals);
			return Math.round(n * div) / div;
		}
		
		/**
		 * Return the sign of a number
		 * @param val	a number
		 * @return 		-1 if the number is less than zero, else 1
		 */
		public static function sgn(val:Number):int 
		{
			if (val < 0) return -1;
			return 1;
		}
		
		/**
		 * Convert a number to a hexadecimal string
		 * @param dec		an integer value
		 * @return 			A hexadecimal string
		 */
		public static function dec2hex (dec:int):String 
		{
			if (dec==0) return "0";
			var hex:String = "";
			while (dec>0)
			{
				hex = hexChars.charAt((dec%16)) + hex;
				dec = Math.floor(dec/16);
			}
			return hex;
		}
	
		/**
		 * Convert a hexadecimal string to a number
		 * @param hex		a string (without # or 0x prefixes)
		 * @return 			a decimal number
		 */
		public static function hex2dec(hex:String):Number 
		{
			return parseInt(hex, 16);
		}
		
		/** conversion ratio from degrees to radians */
		public static const DEG_2_RAD:Number = Math.PI/180; 
		
		/** conversion ratio from radians to degrees */
		public static const RAD_2_DEG:Number = 180/Math.PI; 
		
		
		/**
		 * convert an angle in radians to degrees
		 * @param radians
		 * @return 
		 */
		public static function degrees(radians:Number):Number 
		{
			return radians*RAD_2_DEG;
		}
		
		
		/**
		 * convert an angle in degrees to radians
		 * @param degrees
		 * @return 
		 */
		public static function radians(degrees:Number):Number 
		{
			return degrees*DEG_2_RAD;
		}
		
		/**
		 * Clamp (restrict) a given amount to a number range.
		 * 
		 * @param min the minimum amount allowed to be returned
		 * @param max the maximum amount allowed to be returned
		 * @return the amount between the range min and max 
		 * 
		 */
		public static function clamp(min:Number, max:Number, amount:Number):Number 
		{
			if (amount < min) 		return min
			else if (amount > max) 	return max
			else					return amount
		}
		
		public static function clampPositive(amount:Number):Number 
		{
			if (amount < 0) 	return 0
			else 				return amount
		}
		
		public static function clampToUnitRange(amount:Number):Number 
		{
			return Range.clampToUnitRange(amount)
		}
	}
}
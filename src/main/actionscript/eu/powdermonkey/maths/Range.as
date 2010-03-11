package eu.powdermonkey.maths
{
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;
	
	public class Range extends Proxy
	{
		private static const _unitRange:Range = new Range(0, 1) 
		
		public static function getUnitRange():Range
		{
			return _unitRange
		}
		
		public static function clampToUnitRange(unit:Number):Number
		{
			return _unitRange.clamp(unit)
		}
		
		public static function get randomUnitValue():Number
		{
			return _unitRange.randomValue
		}
		
		public static function isWithinUnitRange(value:Number):Boolean
		{
			return _unitRange.contains(value)
		}
		
		public static function zeroUpto(max:Number):Range
		{
			return new Range(0, max)
		}
		
		public static function zeroUntil(max:Number):Range
		{
			return new Range(0, max-1)
		}
		
		public static function isWithinRangeZeroUpto(max:Number, value:Number):Boolean
		{
			return zeroUpto(max).contains(value)
		}
		
		public static function isOutsideRangeZeroUpto(max:Number, value:Number):Boolean
		{
			return zeroUpto(max).isOutside(value)
		}
		
		public static function oneUpto(max:Number):Range
		{
			return new Range(1, max)
		}
		
		public static function oneUntil(max:Number):Range
		{
			return new Range(1, max-1)
		}
		
				
		private var _min:Number
		
		private var _max:Number
		
		
		public function Range(min:Number, max:Number)
		{
			if (min < max)
			{
				_min = min
				_max = max
			}
			else
			{
				swapValues(min, max)
			}
		}
		
		override flash_proxy function nextNameIndex(index:int):int
		{
			if (index <= length) 
			{
				return index + 1
			}
			else
			{
				return 0
			}
		}		
		
		override flash_proxy function nextValue(index:int):*
		{
			return _min + index - 1		
		}
		
		private function swapValues(min:Number, max:Number):void
		{
			_min = max
			_max = min			
		}
		
		public function clone():Range
		{
			return new Range(_min, _max)
		}
		
		public function cloneMin(newMax:Number):Range
		{
			return new Range(_min, newMax)
		}
		
		public function cloneMax(newMin:Number):Range
		{
			return new Range(newMin, _max)
		}
		
		public function clamp(value:Number):Number
		{
			if (value < _min) 	return min
			if (value > _max) 	return max
			else				return value 
		}
		
		public function get randomValue():Number
		{
			return _min + length * Math.random()
		}
		
		/**
		 * @param unitValue a unit value [0 .. 1], this is not clamped or checked in any way, 
		 * so it is perfectly legal to enter the value 2 into this function if you want.
		 * @return the 
		 */		
		public function valueFromUnitValue(unit:Number):Number
		{
			return _min + length * unit
		}
		
		public function unitValueFromValue(value:Number):Number
		{
			if (length == 0) return 0
			else return (value - min) / length
		}
		
		public function unitValueClamped(value:Number):Number
		{
			if (length == 0) return 0
			else return clampToUnitRange((value - min) / length)
		}
		
		public function get length():Number
		{
			return _max - _min
		}
		
		public function get midPoint():Number
		{
			return (_min + length) / 2
		}
		
		public function contains(value:Number):Boolean
		{
			if (value >= _min && value <= _max)		return true
			else									return false
		}
		
		/**
		 * @param other the Range to test for intersection with.
		 * @return true if either Range is intersecting. 
		 * A Range pair where the two end points are just overlapping is considered an intersection.
		 * @example Shows how a border case is evaluated.
		 * <listing version="3.0" >
		 * 	var a:Range = new Range(10, 15)
		 *	var b:Range = new Range(15, 25)
		 * 	a.isIntersecting(b) => true
		 * </listing> 
		 */		
		public function isIntersecting(other:Range):Boolean
		{
			// see: http://stackoverflow.com/questions/1558901/one-dimensional-line-segments-ranges-intersection-test-solution-name
			// for info about this solution.
			
			// Here is my original solution:
			// view crossA and crossB as one dimensional vectors
			// if they are both facing the same direction (same sign), the ranges are intersecting
			// the product tests for direction sameness
			// a product greater of equal to zero means an intersection
			// var crossA:Number = this._max - other._min
			// var crossB:Number = other._max - this._min
			// var product:Number = crossA * crossB
			// return product >= 0

			return !((this._max < other._min) || (other._max < this._min))
		}
		
		public function intersection(other:Range):Range
		{
			var minWithin:Boolean = contains(other.min) || other.contains(max)
			var maxWithin:Boolean = contains(other.max) || other.contains(min)
			
			if (minWithin && maxWithin)
			{
				return other.clone()
			}
			else if (minWithin)
			{
				return new Range(this._min, other.max)
			}
			else if (maxWithin)
			{
				return new Range(other.min, this._max)
			}
			else
			{
				return null
			}
		}
		
		public function isOutside(value:Number):Boolean
		{
			return !contains(value)
		}
		
		public function isLessThanMin(value:Number):Boolean
		{
			return value < _min
		}
		
		public function isGreaterThanMax(value:Number):Boolean
		{
			return value > _max
		}
		
		public function get biggestValue():Number
		{
			return Math.max(Math.abs(_min), Math.abs(_max))
		}
		
		public function multiply(amount:Number):Range
		{
			return new Range(_min * amount, _max * amount)
		}
		
		public function get min():Number
		{
			return _min
		}
		
		public function get max():Number
		{
			return _max
		}
		
		public function toString():String
		{
			return '[Range ' + _min + '..' + _max + ']'
		}
	}
}
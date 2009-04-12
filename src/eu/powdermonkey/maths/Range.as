package eu.powdermonkey.maths
{
	public class Range
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
			return _unitRange.isWithin(value)
		}
		
		public static function createRangeZeroUpto(max:Number):Range
		{
			return new Range(0, max)
		} 
		
		public static function isWithinRangeZeroUpto(max:Number, value:Number):Boolean
		{
			return createRangeZeroUpto(max).isWithin(value)
		}
		
		public static function isOutsideRangeZeroUpto(max:Number, value:Number):Boolean
		{
			return createRangeZeroUpto(max).isOutside(value)
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
		
		private function swapValues(min:Number, max:Number):void
		{
			_min = max
			_max = min			
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
		
		public function unitValueFromValue(unitValue:Number):Number
		{
			return (unitValue - min) / length
		}
		
		public function get length():Number
		{
			return _max - _min
		}
		
		public function get midPoint():Number
		{
			return (_min + length) / 2
		}
		
		public function isWithin(value:Number):Boolean
		{
			if (value >= _min && value <= _max)		return true
			else									return false
		}
		
		public function isOutside(value:Number):Boolean
		{
			return !isWithin(value)
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
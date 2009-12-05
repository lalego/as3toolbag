package eu.powdermonkey.maths
{
	import flash.geom.Point;
	
	public class PointRange
	{
		private var _x:Range
		 
		private var _y:Range
		
		private var _min:Point
		
		private var _max:Point
		
		public function PointRange(xRange:Range, yRange:Range)
		{
			_x = xRange
			_y = yRange
			_min = new Point(xRange.min, yRange.min)
			_max = new Point(xRange.max, yRange.max)
		}

		public function get x():Range
		{
			return _x
		}

		public function get y():Range
		{
			return _y
		}
		
		public function get min():Point
		{
			return _min
		}
		
		public function get max():Point
		{
			return _max
		}
		
		public function valueFromUnitValue(unit:Number):Point
		{
			return new Point(
				_x.valueFromUnitValue(unit),
				_y.valueFromUnitValue(unit)
			)
		}
		
		public function unitValueFromValue(value:Number):Point
		{
			return new Point(
				_x.unitValueFromValue(value),
				_y.unitValueFromValue(value)
			)
		}
		
		public function toString(): String
		{
			return '[PointRange ' + _min + '..' + _max + ']'
		}
	}
}
package eu.powdermonkey.maths
{
	public class Tolerance extends Range
	{
		public static function buildSymetrical(nominal:Number, tolerance:Number):Tolerance
		{
			return new Tolerance(
				nominal,
				tolerance,
				tolerance
			)
		}
		
		private var _nominal:Number
		
		public function Tolerance(nominal:Number, minus:Number, plus:Number)
		{
			super(nominal - minus, nominal + plus)
			_nominal = nominal
		}
		
		public function get nominal():Number
		{
			return _nominal
		}
		
		override public function unitValueFromValue(value:Number):Number
		{
			if (value < nominal)
			{
				return (value - nominal) / lengthNegative
			}
			else if (value > nominal)
			{
				return (value - nominal) / lengthPositive
			}
			else
			{
				return 0
			}
		}
		
		public function get lengthPositive():Number
		{
			return max - nominal
		}
		
		public function get lengthNegative():Number
		{
			return nominal - min
		}
	}
}
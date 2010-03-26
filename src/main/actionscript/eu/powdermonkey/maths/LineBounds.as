package eu.powdermonkey.maths
{
	public class LineBounds
	{
		private var _min:Number
		
		public function get min():Number
		{
			return _min
		}
		
		private var _max:Number
		
		public function get max():Number
		{
			return _max
		}
		
		public function LineBounds(min:Number, max:Number)
		{
			_min = min
			_max = max
		}
	}
}
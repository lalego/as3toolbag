package eu.powdermonkey.maths
{
	public class PlaneBounds 
	{
		private var _x:LineBounds
		
		public function get x():LineBounds
		{
			return _x
		}
		
		private var _y:LineBounds
		
		public function get y():LineBounds
		{
			return _y
		}
		
		public function PlaneBounds(x:LineBounds, y:LineBounds)
		{
			_x = x
			_y = y
		}
	}
}
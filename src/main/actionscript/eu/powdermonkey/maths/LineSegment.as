package eu.powdermonkey.maths
{
	import flash.geom.Point;
	
	public class LineSegment
	{
		private var _start:Point
		 
		private var _end:Point
		
		public function LineSegment(start:Point, end:Point)
		{
			_start = start
			_end = end
		}
		
		public function get start():Point
		{
			return _start
		}
		
		public function get end():Point
		{
			return _end
		}
	}
}
package eu.powdermonkey.maths
{
	import eu.powdermonkey.utils.strings.intersperseSpaces;
	
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class Bounds
	{
		private var _width:Number
		
		private var _height:Number
		
		public function Bounds(width:Number, height:Number)
		{
			_width = width
			_height = height
		}
		
		public function equals(other:Bounds):Boolean
		{
			return _width == other.width && _height == other.height
		}
		
		public function get width():Number
		{
			return _width
		}
		
		public function get widthHalf():Number
		{
			return _width * 0.5
		}
		
		public function get widthDouble():Number
		{
			return _width * 2
		}
		
		public function get height():Number
		{
			return _height
		}
		
		public function get heightHalf():Number
		{
			return _height * 0.5
		}
		
		public function get heightDouble():Number
		{
			return _height * 2
		}
		
		public function scale(amount:Number):Bounds
		{
			return new Bounds(width * amount, height * amount)
		}
		
		public function toPoint():Point
		{
			return new Point(width, height)
		}
		
		public function toPointHalfed():Point
		{
			return new Point(widthHalf, heightHalf)
		}
		
		public function toPointDoubled():Point
		{
			return new Point(widthDouble, heightDouble)
		}
		
		public function toRectangle():Rectangle
		{
			return new Rectangle(0, 0, _width, _height) 
		}
		
		public function toString():String
		{
			return intersperseSpaces('width:', _width, 'height:', _height) 
		}
	}
}
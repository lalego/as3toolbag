package eu.powdermonkey.utils
{
	import flash.filters.ColorMatrixFilter;
	
	public class ColorMatrixFilterUtil
	{
		public static function buildInversionFilter():ColorMatrixFilter
		{
			var filter:ColorMatrixFilter = new ColorMatrixFilter
			(
				[
					0, 0, 0, 0, 1, 
					0, 0, 0, 0, 1, 
					0, 0, 0, 0, 1, 
					0.33, 0.33, 0.33, 0, 0
				]
			);
			
			return filter
		}
		
		public static function buildGrayscaleFilter():ColorMatrixFilter
		{
			var filter:ColorMatrixFilter = new ColorMatrixFilter
			(
				[	
					0.3086, 0.6094, 0.0820, 0, 0, 
					0.3086, 0.6094, 0.0820, 0, 0, 
					0.3086, 0.6094, 0.0820, 0, 0, 
					0, 0, 0, 1, 0
				]
			)
			
			return filter
		}
		
		public static function fromRGB(red:Number, green:Number, blue:Number):ColorMatrixFilter
		{
			var filter:ColorMatrixFilter = new ColorMatrixFilter
			(
				[	
					red, 0, 0, 0, 0, 
					0, green, 0, 0, 0, 
					0, 0, blue, 0, 0, 
					0, 0, 0, 1, 0
				]
			)
			
			return filter
		}
		
		public static function buildRedFilter():ColorMatrixFilter
		{
			var filter:ColorMatrixFilter = fromRGB(1, 0, 0)
			return filter
		}
		
		public static function buildGreenFilter():ColorMatrixFilter
		{
			var filter:ColorMatrixFilter = fromRGB(0, 1, 0)
			return filter
		}
		
		public static function buildBlueFilter():ColorMatrixFilter
		{
			var filter:ColorMatrixFilter = fromRGB(0, 0, 1)
			return filter
		}
		
		public static function fromHex(hex:uint):ColorMatrixFilter
		{
//			var alphaValue:uint = color >> 24 & 0xFF;
		    var color:Object = ColorUtil.toRGB(hex)
			return fromRGB(color.red, color.green, color.blue)
		}
	}
}
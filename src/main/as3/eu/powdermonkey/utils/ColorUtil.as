package eu.powdermonkey.utils
{
	public class ColorUtil
	{
		public static function add(a:Object, b:Object):Object
		{
			return {
				red: a.red + b.red,
				green: a.green + b.green,
				blue: a.blue + b.blue
			}
		}
		
		public static function sub(a:Object, b:Object):Object
		{
			return {
				red: a.red - b.red,
				green: a.green - b.green,
				blue: a.blue - b.blue
			}
		}
		
		public static function toGrayscale(color:int):int
		{
			var rgb:Object = toRGB(color)
			var mono:Number = 
				0.2989 * rgb.red + 
				0.5870 * rgb.green + 
				0.1140 * rgb.blue
				  
			return toHex(mono, mono, mono)
		}
		
		public static function objectToHex(rgb:Object):int
		{
			return toHex(rgb.red, rgb.green, rgb.blue)
		}
		
		public static function toHex(r:Number, g:Number, b:Number):int
		{
			var range:int = 255
			return (r * range << 16) + (g * range << 8) + b * range
		}
		
		public static function toRGB255(color:int):Object
		{
			var red:Number = Number(color >> 16 & 0xFF)
		    var green:Number = Number(color >> 8 & 0xFF)
		    var blue:Number = Number(color & 0xFF)
		    
			return {
				red: red,
				green: green,
				blue: blue
			}
		}
		
		public static function toRGB(color:int):Object
		{
			var range:int = 255
			var red:Number = Number(color >> 16 & 0xFF) / range
		    var green:Number = Number(color >> 8 & 0xFF) / range
		    var blue:Number = Number(color & 0xFF) / range
		    
			return {
				red: red,
				green: green,
				blue: blue
			}
		}
	}
}
package eu.powdermonkey.io.logging
{
	import eu.powdermonkey.io.logging.formatters.IFormatter;
	
	public class Log
	{
		private static var logger:ILogger
		
		public static function activeLogger(instance:ILogger):void
		{
			if (logger != null)
			{
				logger.warning("An attempt was made to set another logger instance while a logger was already active")	
			}
			else
			{
				logger = instance
			}
		} 
		
		public static function warning(... messages):void
		{
			logger.warning.apply(null, messages)
		}
		
		public static function error(... messages):void
		{
			logger.error.apply(null, messages)
		}
		
		public static function info(... messages):void
		{
			logger.info.apply(null, messages)
		}
		
		public static function debug(... messages):void
		{
			logger.debug.apply(null, messages)
		}
	}
}
package eu.powdermonkey.io.logging
{
	public class Log
	{
		private static var _logger:ILogger
		
		public static function activeLogger(instance:ILogger):void
		{
			if (_logger != null)
			{
				_logger.warning("An attempt was made to set another logger instance while a logger was already active")	
			}
			else
			{
				_logger = instance
			}
		} 
		
		public static function warning(... messages):void
		{
			_logger.warning.apply(null, messages)
		}
		
		public static function error(... messages):void
		{
			_logger.error.apply(null, messages)
		}
		
		public static function info(... messages):void
		{
			_logger.info.apply(null, messages)
		}
		
		public static function debug(... messages):void
		{
			_logger.debug.apply(null, messages)
		}
	}
}
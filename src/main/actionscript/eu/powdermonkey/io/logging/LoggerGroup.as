package eu.powdermonkey.io.logging
{
	import __AS3__.vec.Vector;
	
	public class LoggerGroup implements ILogger
	{
		private var _loggers:Vector.<ILogger> = new Vector.<ILogger>()
		
		public function LoggerGroup(... loggers)
		{
			_loggers = Vector.<ILogger>(loggers)
		}
		
		public function warning(... messages):void
		{
			for each (var logger:ILogger in _loggers)
			{
				logger.warning.apply(null, messages)
			}
		}
		
		public function error(... messages):void
		{
			for each (var logger:ILogger in _loggers)
			{
				logger.error.apply(null, messages)
			}
		}
		
		public function info(... messages):void
		{
			for each (var logger:ILogger in _loggers)
			{
				logger.info.apply(null, messages)
			}
		}
		
		public function debug(... messages):void
		{
			for each (var logger:ILogger in _loggers)
			{
				logger.debug.apply(null, messages)
			}
		}
	}
}
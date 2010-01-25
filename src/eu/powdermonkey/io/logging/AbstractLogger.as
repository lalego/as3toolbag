package eu.powdermonkey.io.logging
{
	import eu.powdermonkey.io.logging.formatters.IFormatter;
	
	public class AbstractLogger implements ILogger
	{
		private var formatter:IFormatter
		
		public function AbstractLogger(formatter:IFormatter)
		{
			this.formatter = formatter
		}
		
		public function warning(... messages):void
		{
			logMessage('Warning', messages)
		}
		
		public function error(... messages):void
		{
			logMessage('Error', messages)
		}
		
		public function info(... messages):void
		{
			logMessage('Info', messages)
		}
		
		public function debug(... messages):void
		{
			logMessage('Debug', messages)
		}
		
		/**
		 * @param type
		 * @param messages
		 */		
		private function logMessage(type:String, messages:Array):void
		{
			messages.unshift(type)
			var message:String = formatter.format.apply(null, messages)
			log(type, message)
		}
		
		protected function log(type:String, message:String):void
		{
			trace(message)
		}
	}
}
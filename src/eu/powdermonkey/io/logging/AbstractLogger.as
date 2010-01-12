package eu.powdermonkey.io.logging
{
	import eu.powdermonkey.utils.StringUtil;
	
	public class AbstractLogger implements ILogger
	{
		public function warning(... messages):void
		{
			log('Warning', messages)
		}
		
		public function error(... messages):void
		{
			log('Error', messages)
		}
		
		public function info(... messages):void
		{
			log('Info', messages)
		}
		
		public function debug(... messages):void
		{
			log('Debug', messages)
		}
		
		/**
		 * 
		 * @param type
		 * @param messages
		 * 
		 */		
		protected function log(type:String, messages:Array):void
		{
			messages.unshift(buildLogPrefix(type))
			trace.apply(null, messages)
		}
		
		/**
		 * 
		 * @param type
		 * @return 
		 * 
		 */
		protected function buildLogPrefix(type:String):String
		{
			return '[' + type + ': ' + timeStamp() + ']:' 
		}
		
		protected function timeStamp():String
		{
			return new Date().toString()
		}
	}
}
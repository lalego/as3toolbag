package eu.powdermonkey.io.logging.formatters
{
	import eu.powdermonkey.utils.strings.intersperseSpaces;
	
	public class AbstractFormatter implements IFormatter
	{
		public function format(type:String, ... messages):String
		{
			return logPrefix(type, messages) + logMessage(type, messages) 
		}
		
		protected function logMessage(type:String, messages:Array):String
		{
			return intersperseSpaces.apply(null, messages)	
		}
		
		protected function logPrefix(type:String, messages:Array):String
		{
			return '[' + type + ': ' + timeStamp() + ']:'
		}
		
		protected function timeStamp():String
		{
			return new Date().toString()
		}
	}
}
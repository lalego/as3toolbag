package eu.powdermonkey.io.logging
{
	import eu.powdermonkey.io.logging.formatters.IFormatter;
	
	public class TraceLogger extends AbstractLogger
	{
		public function TraceLogger(formatter:IFormatter)
		{
			super(formatter)
		}
		
		override protected function log(type:String, message:String):void
		{
			trace(message)
		}
	}
}
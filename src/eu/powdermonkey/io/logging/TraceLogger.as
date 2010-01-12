package eu.powdermonkey.io.logging
{
	import eu.powdermonkey.utils.StringUtil;
	
	public class TraceLogger extends AbstractLogger
	{
		override protected function log(type:String, messages:Array):void
		{
			messages.unshift(buildLogPrefix(type))
			var logMessage:String = StringUtil.intersperseSpace.apply(null, messages)
			trace(logMessage)
		}
	}
}
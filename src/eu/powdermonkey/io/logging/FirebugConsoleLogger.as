package eu.powdermonkey.io.logging
{
	import eu.powdermonkey.utils.StringUtil;
	import flash.external.ExternalInterface;
	
	/**
	 * A logger that outpus to the FireBug console. 
	 * http://getfirebug.com/console.html 
	 */	
	public class FirebugConsoleLogger extends AbstractLogger
	{
		override protected function log(type:String, messages:Array):void
		{
			messages.unshift(buildLogPrefix(type))
			var logMessage:String = StringUtil.intersperseSpace.apply(null, messages)
			ExternalInterface.call('console.' + type.toLowerCase(), logMessage)
		}
	}
}
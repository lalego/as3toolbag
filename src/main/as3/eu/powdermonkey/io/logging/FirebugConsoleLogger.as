package eu.powdermonkey.io.logging
{
	import eu.powdermonkey.io.logging.formatters.IFormatter;
	
	import flash.external.ExternalInterface;
	
	/**
	 * A logger that outpus to the FireBug console. 
	 * http://getfirebug.com/console.html 
	 */	
	public class FirebugConsoleLogger extends AbstractLogger
	{
		public function FirebugConsoleLogger(formatter:IFormatter)
		{
			super(formatter)
		}
		
		override protected function log(type:String , message:String):void
		{
			ExternalInterface.call('console.' + type.toLowerCase(), message)
		}
	}
}
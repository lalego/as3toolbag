package eu.powdermonkey.io.logging.methods
{
	import eu.powdermonkey.io.logging.Log;
	
	public function info(...messages):void
	{
		Log.info.apply(null, messages)
	}
}
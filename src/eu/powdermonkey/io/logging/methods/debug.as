package eu.powdermonkey.io.logging.methods
{
	import eu.powdermonkey.io.logging.Log;
	
	public function debug(...messages):void
	{
		Log.debug.apply(null, messages)
	}
}
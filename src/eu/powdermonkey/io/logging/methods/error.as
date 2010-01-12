package eu.powdermonkey.io.logging.methods
{
	import eu.powdermonkey.io.logging.Log;
	
	public function error(...messages):void
	{
		Log.error.apply(null, messages)
	}
}
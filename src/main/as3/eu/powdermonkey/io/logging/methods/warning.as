package eu.powdermonkey.io.logging.methods
{
	import eu.powdermonkey.io.logging.Log;
	
	public function warning(...messages):void
	{
		Log.warning.apply(null, messages)
	}
}
package eu.powdermonkey.io.logging.methods
{
	import eu.powdermonkey.io.logging.Log;
	
	public function error(...messages):*
	{
		Log.error.apply(null, messages)
		return null // if this is used in an inline if then null will be returned
	}
}
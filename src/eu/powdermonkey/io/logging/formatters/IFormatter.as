package eu.powdermonkey.io.logging.formatters
{
	public interface IFormatter
	{
		function format(type:String, ... messages):String
	}
}
package eu.powdermonkey.io.logging
{
	public interface ILogger
	{
		function warning(... message):void
		function error(... message):void
		function info(... message):void
		function debug(... message):void
	}
}
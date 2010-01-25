package eu.powdermonkey.io.logging.formatters
{
	public class TimeMilliFormatter extends AbstractFormatter
	{
		override protected function timeStamp():String
		{
			var date:Date = new Date()
			return date.getMinutes() + ':' + date.getSeconds() + ':' + date.getMilliseconds()
		}
	}
}
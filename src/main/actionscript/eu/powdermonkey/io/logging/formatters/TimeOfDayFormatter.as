package eu.powdermonkey.io.logging.formatters
{
	public class TimeOfDayFormatter extends AbstractFormatter
	{
		override protected function timeStamp():String
		{
			var date:Date = new Date()
			return date.getHours() + ':' + date.getMinutes() + ':' 
				+ date.getSeconds() + ':' + date.getMilliseconds()
		}
	}
}
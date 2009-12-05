package eu.powdermonkey.events
{
	import flash.events.IEventDispatcher;
	
	public class EventUtil
	{
		public static function listenForAll(source:IEventDispatcher, callback:Function, eventTypes:Array, weakListener:Boolean = true):void
		{
			for each (var eventType:String in eventTypes)
			{
				source.addEventListener(eventType, callback, false, 0, weakListener)
			}
		}
	}
}
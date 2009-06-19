package eu.powdermonkey.events
{
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	
	public class EventForwarder
	{
		public static function forwardEvent(from:IEventDispatcher, dispatcher:IEventDispatcher, type:String):EventForwarder
		{
			var eventForwarder:EventForwarder = new EventForwarder(from, dispatcher)
			eventForwarder.forwardEvent(type, false)
			return eventForwarder
		}
		
		private var _from:IEventDispatcher
		
		private var _dispatcher:IEventDispatcher
		
		public function EventForwarder(from:IEventDispatcher, dispatcher:IEventDispatcher)
		{
			_from = from
			_dispatcher = dispatcher
		}
		
		public function forwardEvent(type:String, useWeakReference:Boolean=true):void
		{
			_from.addEventListener
			(
				type,
				function (event:Event):void
				{
					_dispatcher.dispatchEvent(event)
				},
				false,
				0,
				true
			)
		}
	}
}
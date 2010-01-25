package eu.powdermonkey.events
{
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class EventTimer
	{
		public static function start(eventDispatcher:IEventDispatcher, event:Event, timeoutMilli:int):void
		{
			var eventTimer:EventTimer = new EventTimer(eventDispatcher, event, timeoutMilli, null)
			eventTimer.start()
		}
		
		public static function startWithValidityCheck(eventDispatcher:IEventDispatcher, event:Event, timeoutMilli:int, validityCallback:Function=null):void
		{
			var eventTimer:EventTimer = new EventTimer(eventDispatcher, event, timeoutMilli, validityCallback)
			eventTimer.start()
		}
		
		private var _defaultValidityCallback:Function = function ():Boolean { return true }
		
		private var _timer:Timer
		
		public function EventTimer(eventDispatcher:IEventDispatcher, event:Event, timeoutMilli:int, validityCallback:Function=null)
		{
			if (validityCallback == null)
			{
				validityCallback = _defaultValidityCallback
			}
			
			_timer = new Timer(timeoutMilli, 1)
			_timer.addEventListener
			(
				TimerEvent.TIMER,
				function (event:TimerEvent):void
				{
					var isValid:Boolean = validityCallback()
					
					if (isValid)
					{
						eventDispatcher.dispatchEvent(event)
					}
				}
			)
		}
		
		public function start():void
		{
			_timer.start()
		}
	}
}


package eu.powdermonkey.events
{
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	
	public class EventUtil
	{
		
		public static function addListenerTo(
											dispatcher:IEventDispatcher, 
											type:String, 
											callback:Function, 
											useCapture:Boolean=false, 
											priority:int=0,
											userWeakListener:Boolean=false
								):void
		{
			dispatcher.addEventListener(type, callback, useCapture, priority, userWeakListener) 
		}
		
		public static function addWeakListenerTo(
											dispatcher:IEventDispatcher, 
											type:String, 
											callback:Function, 
											useCapture:Boolean=false, 
											priority:int=0
								):void
		{
			dispatcher.addEventListener(type, callback, useCapture, priority, true) 
		}
		
		public static function addSelfRemovingListener(
											dispatcher:IEventDispatcher, 
											type:String, 
											callback:Function, 
											useCapture:Boolean=false, 
											priority:int=0
								):void
		{
			dispatcher.addEventListener
			(
				type,
				function (event:Event):void
				{
					dispatcher.removeEventListener(type, arguments.callee)
					callback(event)
				},
				useCapture, 
				priority
			)
		}
		
		public static function eventMap(
									dispatcher:IEventDispatcher, 
									type:String, 
									mapToEvent:Event
								):void
		{
			dispatcher.addEventListener(
				type, 
				function ():void 
				{
					dispatcher.dispatchEvent(mapToEvent)
				}
			)
		}
		
		public static function eventMapWeak(
									dispatcher:IEventDispatcher, 
									type:String, 
									mapToEvent:Event
								):void
		{
			EventUtil.addWeakListenerTo(
				dispatcher, 
				type,
				function ():void 
				{
					dispatcher.dispatchEvent(mapToEvent)
				}
			)
		}
		
		public static function eventMapOneShot(
									dispatcher:IEventDispatcher, 
									type:String, 
									mapToEvent:Event
								):void
		{
			EventUtil.addSelfRemovingListener(
				dispatcher, 
				type,
				function ():void 
				{
					dispatcher.dispatchEvent(mapToEvent)
				}
			)
		}
		
		public static function addListenerForAll(
									source:IEventDispatcher, 
									eventTypes:Array, 
									callback:Function, 
									weakListener:Boolean = false
								):void
		{
			for each (var eventType:String in eventTypes)
			{
				source.addEventListener(eventType, callback, false, 0, weakListener)
			}
		}
		
		public static function addListenerToAllForAll(
									sourceList:Array /* of IEventDispatcher */, 
									eventTypeList:Array /* of Event*/, 
									callback:Function, 
									weakListener:Boolean = false
								):void
		{
			for each (var eventSource:IEventDispatcher in sourceList)
			{
				EventUtil.addListenerForAll(eventSource, eventTypeList, callback, weakListener)
			}
		}
		
		public static function removeListenerForAll(
									source:IEventDispatcher, 
									eventTypes:Array, 
									callback:Function, 
									weakListener:Boolean = false
								):void
		{
			for each (var eventType:String in eventTypes)
			{
				source.removeEventListener(eventType, callback, false)
			}
		}
		
		public static function dispatchAll(source:IEventDispatcher, events:Array):void
		{
			for each (var event:Event in events)
			{
				source.dispatchEvent(event)
			}
		}
		
		public static function traceEvent(event:Event):void
		{
			trace(event)
		}
	}
}
package eu.powdermonkey.events
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	
	public class EventSynchronizer extends EventDispatcher
	{
		private var waitingOn:Dictionary = new Dictionary()
		
		private var dependancyAmount:int = 0
		
		public function EventSynchronizer()
		{
		}
		
		public function addDependancy(eventDispatcher:IEventDispatcher, listenForType:String):void
		{
			var eventTypeBag:EventTypeBag
			
			if (waitingOn[eventDispatcher] == null)
			{
				eventTypeBag = new EventTypeBag()
				eventTypeBag.add(listenForType)
			} 
			else
			{
				eventTypeBag = waitingOn[eventDispatcher]
				eventTypeBag.add(listenForType)
			}
			
			waitingOn[eventDispatcher] = eventTypeBag
			dependancyAmount++
			eventDispatcher.addEventListener(listenForType, onEventRecieved)
		}
		
		private function onEventRecieved(event:Event):void
		{
			var eventDispatcher:IEventDispatcher = IEventDispatcher(event.target)
			var eventTypeBag:EventTypeBag = waitingOn[eventDispatcher]
			
			if (eventTypeBag.amount(event.type) > 0)
			{
				eventTypeBag.remove(event.type)
				
				if (eventTypeBag.amount(event.type) == 0)
				{
					eventDispatcher.removeEventListener(event.type, onEventRecieved)
				}
				
				if (dependancyAmount > 0)
				{
					dependancyAmount--
					
					if (dependancyAmount == 0)
					{
						dispatchEvent(new SyncEvent())
					}
				}
			}
		}
	}
}

import flash.utils.Dictionary;

class EventTypeBag
{
	private var _events:Dictionary = new Dictionary()
	
	private var _eventAmout:int = 0
	
	public function add(type:String):void
	{
		if (_events[type] == null)
		{
			_events[type] = 1
		}
		else
		{
			var amount:int = _events[type]
			amount++
			_events[type] = amount
		}
		
		_eventAmout++
	}
	
	public function remove(type:String):void
	{
		if (_events[type] == null)
		{
			throw new Error("This bag contains no event of type: " + type)
		}
		else
		{
			var amount:int = _events[type]
			
			if (amount == 0)
			{
				throw new Error("This bag contains no event of type: " + type)
			}
			
			amount--
			_eventAmout--
			_events[type] = amount
		}
	}
	
	public function amount(type:String):int
	{
		return _events[type]
	}
	
	public function get isEmpty():Boolean
	{
		return _eventAmout == 0
	}
}
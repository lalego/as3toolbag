package eu.powdermonkey.events
{
	import __AS3__.vec.Vector;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.utils.Dictionary;
	
	public class EventSync extends EventDispatcher
	{
		private var _waitingOn:Dictionary = new Dictionary()
		
		private var _received:Vector.<Event> = new Vector.<Event>()
		
		private var _dependancyAmount:int = 0
		
		public function addDependancy(eventDispatcher:IEventDispatcher, listenForType:String):EventSync
		{
			var eventTypeBag:EventTypeBag
			
			if (_waitingOn[eventDispatcher] == null)
			{
				eventTypeBag = new EventTypeBag()
				eventTypeBag.add(listenForType)
			} 
			else
			{
				eventTypeBag = _waitingOn[eventDispatcher]
				eventTypeBag.add(listenForType)
			}
			
			_waitingOn[eventDispatcher] = eventTypeBag
			_dependancyAmount++
			eventDispatcher.addEventListener(listenForType, onEventRecieved)
			
			return this
		}
		
		private function onEventRecieved(event:Event):void
		{
			_received.push(event)
			var eventDispatcher:IEventDispatcher = IEventDispatcher(event.target)
			var eventTypeBag:EventTypeBag = _waitingOn[eventDispatcher]
			
			if (eventTypeBag.amount(event.type) > 0)
			{
				eventTypeBag.remove(event.type)
				
				if (eventTypeBag.amount(event.type) == 0)
				{
					eventDispatcher.removeEventListener(event.type, onEventRecieved)
				}
				
				if (_dependancyAmount > 0)
				{
					_dependancyAmount--
					
					if (_dependancyAmount == 0)
					{
						dispatchEvent(new SyncEvent(_received))
					}
				}
			}
		}
	}
}

import flash.utils.Dictionary;
import __AS3__.vec.Vector;
import flash.events.Event;

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
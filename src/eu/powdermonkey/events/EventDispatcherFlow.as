package eu.powdermonkey.events
{
	import eu.powdermonkey.collections.ArrayIterator;
	import eu.powdermonkey.collections.IIterator;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;

	public class EventDispatcherFlow extends EventDispatcher
	{
		private static const TRIGGER_EVENT_TYPE:String = Event.COMPLETE
		
		private var _states:IIterator
		
		private var _active:IEventDispatcher 
		
		public function EventDispatcherFlow(states:Array /* of IIterator */)
		{
			_states = new ArrayIterator(states)
		}
		
		public function start():void
		{
			activateNextState()
		}
		
		public function pause():void
		{
			
		}
		
		public function get isStarted():Boolean
		{
			return _active != null
		}
		
		private function activateNextState():void
		{
			if (_active != null)
			{
				_active.removeEventListener(TRIGGER_EVENT_TYPE, onTrigger) 
			}
			
			if (_states.hasNext)
			{
				_active = _states.next()
				_active.addEventListener(TRIGGER_EVENT_TYPE, onTrigger)
			}
			else
			{
				dispatchEvent(new Event(Event.COMPLETE))
			}
		}
		
		private function onTrigger(event:Event):void
		{
			activateNextState()
		}
	}
}
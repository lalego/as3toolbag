package eu.powdermonkey.events
{
	import eu.powdermonkey.collections.ArrayList;
	import eu.powdermonkey.collections.IIterator;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;

	public class EventDispatcherFlow extends EventDispatcher
	{
		private static const TRIGGER_EVENT_TYPE:String = Event.COMPLETE
		
		private var _states:Array
		
		private var _statesIterator:IIterator
		
		private var _active:IEventDispatcher 
		
		public function EventDispatcherFlow(states:Array /* of IIterator */)
		{
			_states = states
		}
		
		public function start():void
		{
			_statesIterator = new ArrayList(_states)
			activateNextState()
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
			
			if (_statesIterator.hasNext)
			{
				var deactivated:IEventDispatcher = _active
				_active = _statesIterator.next()
				dispatchEvent(new FlowStateActiveEvent(FlowStateActiveEvent.ACTIVE, _active, deactivated))
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
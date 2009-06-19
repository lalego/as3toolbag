package eu.powdermonkey.events
{
	import flash.events.Event;
	import flash.events.IEventDispatcher;

	public class FlowStateActiveEvent extends Event
	{
		public static const ACTIVE:String = 'FlowStateActiveEvent.STATE_ACTIVATED'
		
		private var _activated:IEventDispatcher
		
		private var _deactivated:IEventDispatcher
		
		public function FlowStateActiveEvent(type:String, activated:IEventDispatcher, deactivated:IEventDispatcher=null)
		{
			super(type, true, false);
			_activated = activated
			_deactivated = deactivated
		}
		
		public function get activated():IEventDispatcher
		{
			return _activated
		}
		
		public function get hasDeactivated():Boolean
		{
			return _deactivated != null
		}
		
		public function get deactivated():IEventDispatcher
		{
			return _deactivated
		}
		
		override public function clone():Event
		{
			return new FlowStateActiveEvent(type, _activated, _deactivated)
		}
	}
}
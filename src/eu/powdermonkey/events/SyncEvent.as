package eu.powdermonkey.events
{
	import __AS3__.vec.Vector;
	
	import flash.events.Event;
	import flash.utils.getQualifiedClassName;

	public class SyncEvent extends Event
	{
		public static const ACTIVATE:String = getQualifiedClassName(SyncEvent) + '.ACTIVATE'
		
		private var _events:Vector.<Event>
		
		public function SyncEvent(events:Vector.<Event>)
		{
			_events = events
			super(SyncEvent.ACTIVATE, false, false);
		}
		
		public function get events():Vector.<Event>
		{
			return _events 
		}
		
		/** 
		 * throws an error if the event is not found
		 */
		public function getEventByClass(clazz:Class):*
		{
			for each (var event:Event in _events)
			{
				if (event is clazz)
				{
					return event
				}
			}
			
			throw new Error("Event of class '" + clazz + "' was not found")
		}
		
		override public function clone():Event
		{
			return new SyncEvent(_events)
		} 
	}
}
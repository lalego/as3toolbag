package eu.powdermonkey.events
{
	import flash.events.Event;

	public class SyncEvent extends Event
	{
		public static const ACTIVATE:String = 'SyncEvent.ACTIVATE'
		
		public function SyncEvent()
		{
			super(SyncEvent.ACTIVATE, false, false);
		}
		
		override public function clone():Event
		{
			return new SyncEvent()
		} 
	}
}
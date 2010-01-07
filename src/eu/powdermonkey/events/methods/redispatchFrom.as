package eu.powdermonkey.events.methods
{
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	
	public function redispatchFrom(eventAvatar:Event, eventDispatcher:IEventDispatcher):Function
	{
		return function (event:Event):void
		{
			eventDispatcher.dispatchEvent(eventAvatar)
		}
	}
}

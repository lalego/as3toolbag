package eu.powdermonkey.events.methods
{
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	
	public function removeListenerWhenFired(callback:Function, useCapture:Boolean = false):Function
	{
		return function (event:Event):void
		{
			var eventDispatcher:IEventDispatcher = IEventDispatcher(event.target)
			eventDispatcher.removeEventListener(event.type, arguments.callee, useCapture)
			callback(event)
		}
	}
}
package eu.powdermonkey.resourcemanagement
{
	import flash.events.IEventDispatcher;
	
	[Event(name='complete', type="flash.events.Event")]
	public interface ILoadable extends IEventDispatcher
	{
		function load():void
	}
}
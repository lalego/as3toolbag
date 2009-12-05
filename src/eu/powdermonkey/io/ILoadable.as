package eu.powdermonkey.io
{
	import flash.events.IEventDispatcher;
	
	[Event(name='complete', type="flash.events.Event")]
	public interface ILoadable extends IEventDispatcher
	{
		function load():void
		
		function get isLoading():Boolean
		
		function get isLoaded():Boolean
		
		function get hasFailed():Boolean
	}
}
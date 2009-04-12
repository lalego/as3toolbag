package eu.powdermonkey.resourcemanagement
{
	import flash.events.Event;

	public class LoadingSequenceEvent extends Event
	{
		public static const RESOURCE_LOADED:String = 'LoadingSequenceEvent.RESOURCE_LOADED'
		
		private var _resource:ResourceLoader
		
		public function LoadingSequenceEvent(resource:ResourceLoader, type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_resource = resource
		}
		
		public function get resourceContent():*
		{
			return _resource.content
		}
		
		public function get resourceLoader():ResourceLoader
		{
			return _resource
		}
		
		override public function clone():Event
		{
			return new LoadingSequenceEvent(_resource, type, bubbles, cancelable)
		}
	}
}
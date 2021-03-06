package eu.powdermonkey.io
{
	import flash.events.Event;

	public class LoadingSequenceEvent extends Event
	{
		public static const RESOURCE_LOADED:String = 'LoadingSequenceEvent.RESOURCE_LOADED'
		
		private var _resource:ResourceLoader
		
		public function LoadingSequenceEvent(resource:ResourceLoader, type:String)
		{
			super(type, false, false);
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
			return new LoadingSequenceEvent(_resource, type)
		}
	}
}
package eu.powdermonkey.resourcemanagement
{
	import eu.powdermonkey.collections.ArrayIterator;
	import eu.powdermonkey.collections.IIterator;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.utils.Dictionary;
	
	public class LoadingSequence extends EventDispatcher
	{
		private var _awaitingLoadIterator:IIterator
		
		private var _loading:Dictionary = new Dictionary()
		
		private var _completed:Array = []
		
		private var _failures:Array = []
		
		public function LoadingSequence(resourceLoaders:Array /* of ResourceLoader */)
		{
			_awaitingLoadIterator = new ArrayIterator(resourceLoaders)
		}
		
		public function load():void
		{
			tryLoadNext()
		}
		
		private function tryLoadNext():void
		{
			if (_awaitingLoadIterator.hasNext)
			{
				var loader:ResourceLoader = _awaitingLoadIterator.next()
				loader.addEventListener(Event.COMPLETE, onLoadComplete)
				loader.addEventListener(ProgressEvent.PROGRESS, onProgress)
				loader.addEventListener(IOErrorEvent.IO_ERROR, onLoadIOError)
				loader.load()
			}
			else
			{
				dispatchEvent(new Event(Event.COMPLETE))
			}
		}
		
		private function onProgress(event:ProgressEvent):void
		{
			
		}
		
		private function onLoadComplete(event:Event):void
		{
			var loader:ResourceLoader = ResourceLoader(event.target) 
			delete _loading[loader]
			dispatchEvent(new LoadingSequenceEvent(loader, LoadingSequenceEvent.RESOURCE_LOADED))
			tryLoadNext()
		}
		
		private function onLoadIOError(event:IOErrorEvent):void
		{
			var loader:ResourceLoader = ResourceLoader(event.target) 
			delete _loading[loader]
			_failures.push(loader)
		}
	}
}
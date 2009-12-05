package eu.powdermonkey.io
{
	import eu.powdermonkey.collections.ArrayIterator;
	import eu.powdermonkey.collections.IIterator;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.HTTPStatusEvent;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	
	[Event(name="complete", type="flash.events.Event")]
	[Event(name="ioError", type="flash.events.IOErrorEvent")]
	[Event(name="httpStatus", type="flash.events.HTTPStatusEvent")]
	[Event(name="securityError", type="flash.events.SecurityErrorEvent")]
	[Event(name="progress", type="eu.powdermonkey.resourcemanagement.LoadingSequenceProgressEvent")]
	[Event(name="resourceLoaded", type="eu.powdermonkey.resourcemanagement.LoadingSequenceEvent")]
	public class LoadingSequence extends EventDispatcher implements ILoadable
	{
		private var _awaitingLoadIterator:IIterator
		
		private var _resourcesToLoad:int = 0
		
		private var _resourcesLoaded:int = 0
		
		private var _loading:ILoadable
		
		private var _failures:Array = []
		
		private var _isLoading:Boolean = false
		
		private var _isLoaded:Boolean = false
		
		private var _hasFailed:Boolean = false
		
		public function LoadingSequence(loadables:Array /* of ILoadable */)
		{
			_resourcesToLoad = loadables.length
			_awaitingLoadIterator = new ArrayIterator(loadables)
		}
		
		public function get id():String
		{
			return toString()
		}
		
		public function load():void
		{
			_isLoading = true
			tryLoadNext()
		}
		
		public function get isLoading():Boolean
		{
			return _isLoading
		}
		
		public function get isLoaded():Boolean
		{
			return _isLoaded
		}
		
		public function get hasFailed():Boolean
		{
			return _hasFailed
		}
		
		private function tryLoadNext():void
		{
			if (_awaitingLoadIterator.hasNext)
			{
				var loadable:ILoadable = _awaitingLoadIterator.next()
				
				if (loadable.isLoaded)
				{ 
					tryLoadNext()
				}
				else
				{
					addlistenersToLoadable(loadable)
					loadable.load()
					_loading = loadable
				}
			}
			else
			{
				_isLoading = false
				_isLoaded = true
				dispatchEvent(new Event(Event.COMPLETE))
			}
		}
		
		private function addlistenersToLoadable(loadable:ILoadable):void
		{
			loadable.addEventListener(Event.COMPLETE, onLoadableLoaded)
			loadable.addEventListener(LoadingSequenceProgressEvent.PROGRESS, onLoadableProgress)
			loadable.addEventListener(IOErrorEvent.IO_ERROR, onLoadIOError)
			loadable.addEventListener(HTTPStatusEvent.HTTP_STATUS, onHttpStatus)
		}
		
		private function removelistenersFromLoadable(loadable:ILoadable):void
		{
			loadable.removeEventListener(Event.COMPLETE, onLoadableLoaded)
			loadable.removeEventListener(LoadingSequenceProgressEvent.PROGRESS, onLoadableProgress)
			loadable.removeEventListener(IOErrorEvent.IO_ERROR, onLoadIOError)
			loadable.removeEventListener(HTTPStatusEvent.HTTP_STATUS, onHttpStatus)
		}
		
		private function onLoadableProgress(event:LoadingSequenceProgressEvent):void
		{
			var progressStart:Number = Number(_resourcesLoaded) / _resourcesToLoad
			var progressEnd:Number = Number(_resourcesLoaded + 1) / _resourcesToLoad
			var progress:Number = progressStart + (event.progress * (progressEnd - progressStart))
			dispatchEvent(new LoadingSequenceProgressEvent(progress))
		}
		
		private function onLoadableLoaded(event:Event):void
		{
			_loading = null
			var loadable:ILoadable = ILoadable(event.target)
			_resourcesLoaded++
			
			var progress:Number = Number(_resourcesLoaded) / _resourcesToLoad
			dispatchEvent(new LoadingSequenceProgressEvent(progress))
			
			if (loadable is ResourceLoader)
			{
				var resourceLoader:ResourceLoader = ResourceLoader(loadable)
				dispatchEvent(new LoadingSequenceEvent(resourceLoader, LoadingSequenceEvent.RESOURCE_LOADED))
			}
			
			removelistenersFromLoadable(loadable)
			tryLoadNext()
		}
		
		private function onLoadIOError(event:IOErrorEvent):void
		{
			var loadable:IEventDispatcher = IEventDispatcher(event.target)
			_hasFailed = true 
			_failures.push(loadable)
			dispatchEvent(event)
		}
		
		public function get loadingID():String
		{
			return _loading.id
		}
		
		public function onHttpStatus(event:HTTPStatusEvent):void
		{
			dispatchEvent(event)
		}
	}
}
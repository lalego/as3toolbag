package eu.powdermonkey.io
{
	import eu.powdermonkey.collections.ArrayList;
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
	[Event(name="progress", type="eu.powdermonkey.io.LoadingSequenceProgressEvent")]
	[Event(name="resourceLoaded", type="eu.powdermonkey.io.LoadingSequenceEvent")]
	public class LoadingSequence extends EventDispatcher implements ILoadable
	{
		private var awaitingLoadIterator:IIterator
		
		private var resourcesToLoad:int = 0
		
		protected var resourcesLoaded:int = 0
		
		private var loading:ILoadable
		
		private var failures:Array = []
		
		private var _isLoading:Boolean = false
		
		private var _isLoaded:Boolean = false
		
		private var _hasFailed:Boolean = false
		
		private var loadables:Array
		
		public function LoadingSequence(loadables:Array /* of ILoadable */)
		{
			this.loadables = loadables
			resourcesToLoad = loadables.length
			awaitingLoadIterator = new ArrayList(loadables)
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
		
		public function get failure():Error
		{
			return null
		}
		
		private function tryLoadNext():void
		{
			if (awaitingLoadIterator.hasNext)
			{
				var loadable:ILoadable = awaitingLoadIterator.next()
				
				if (loadable.isLoaded)
				{ 
					tryLoadNext()
				}
				else
				{
					addlistenersToLoadable(loadable)
					loadable.load()
					loading = loadable
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
			var progressStart:Number = Number(resourcesLoaded) / resourcesToLoad
			var progressEnd:Number = Number(resourcesLoaded + 1) / resourcesToLoad
			var progress:Number = progressStart + (event.progress * (progressEnd - progressStart))
			dispatchEvent(new LoadingSequenceProgressEvent(progress))
		}
		
		private function onLoadableLoaded(event:Event):void
		{
			loading = null
			var loadable:ILoadable = ILoadable(event.target)
			resourcesLoaded++
			
			var progress:Number = Number(resourcesLoaded) / resourcesToLoad
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
			failures.push(loadable)
			dispatchEvent(event)
		}
		
		public function get loadingID():String
		{
			return loading.id
		}
		
		public function onHttpStatus(event:HTTPStatusEvent):void
		{
			dispatchEvent(event)
		}
	}
}
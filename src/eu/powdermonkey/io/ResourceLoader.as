package eu.powdermonkey.io
{
	import eu.powdermonkey.events.EventUtil;
	
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.media.Sound;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	public class ResourceLoader extends EventDispatcher implements ILoadable
	{
		private var _url:String
		
		private var _content:*
		
		private var _isLoading:Boolean = false
		
		private var _isLoaded:Boolean = false
		
		private var _hasFailed:Boolean = false
		
		public function ResourceLoader(url:String)
		{
			_url = url
		}
		
		private function isURLAudio(url:String):Boolean
		{
			return url.search(/\.mp3$/) >= 0
		}
		
		private function isURLBinary(url:String):Boolean
		{
			return url.search(/\.(swf|png|jpg|jpeg|gif)$/) >= 0
		}
		
		public function load():void
		{
			if (isURLAudio(_url))			loadAudioResource(_url)
			else if (isURLBinary(_url))		loadBinaryResource(_url)
			else							loadTextResource(_url)
		}
		
		private function loadAudioResource(url:String):void
		{
			var sound:Sound = new Sound()
				
			var eventTypes:Array = 
			[
				Event.ACTIVATE, Event.DEACTIVATE, Event.ID3, 
				Event.OPEN, Event.UNLOAD, IOErrorEvent.IO_ERROR, 
				ProgressEvent.PROGRESS
			]
			
			sound.addEventListener
			(
				Event.COMPLETE,
				function (event:Event):void 
				{
					_content = sound
					passOnEvent(event)
				}
			)
			
			EventUtil.listenForAll(sound, passOnEvent, eventTypes)
			
			sound.load(new URLRequest(url))
		}
		
		private function loadTextResource(url:String):void
		{
			var urlLoader:URLLoader = new URLLoader()
				
			var eventTypes:Array = 
			[
				Event.ACTIVATE, Event.DEACTIVATE, Event.INIT, 
				Event.OPEN, Event.UNLOAD, HTTPStatusEvent.HTTP_STATUS, 
				IOErrorEvent.IO_ERROR, ProgressEvent.PROGRESS
			]
			
			urlLoader.addEventListener
			(
				Event.COMPLETE,
				function (event:Event):void 
				{
					_content = urlLoader.data
					passOnEvent(event)
				}
			)
			
			EventUtil.listenForAll(urlLoader, passOnEvent, eventTypes)

			urlLoader.load(new URLRequest(url))
		}
		
		private function loadBinaryResource(url:String):void
		{
			var loader:Loader = new Loader()
				
			var eventTypes:Array = 
			[
				Event.ACTIVATE, Event.DEACTIVATE, Event.INIT, 
				Event.OPEN, Event.UNLOAD, HTTPStatusEvent.HTTP_STATUS, 
				IOErrorEvent.IO_ERROR, ProgressEvent.PROGRESS
			]
			
			loader.contentLoaderInfo.addEventListener
			(
				Event.COMPLETE,
				function (event:Event):void 
				{
					_content = loader.contentLoaderInfo.content
					passOnEvent(event)
				}
			)
			
			EventUtil.listenForAll(loader.contentLoaderInfo, passOnEvent, eventTypes)
			
			loader.load(new URLRequest(url))
		}
		
		public function get url():String
		{
			return _url
		}
		
		public function get content():*
		{
			return _content
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
		
		private function passOnEvent(event:Event):void
		{
			dispatchEvent(event)
		}
	}
}
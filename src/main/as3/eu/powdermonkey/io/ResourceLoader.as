package eu.powdermonkey.io
{
	import eu.powdermonkey.events.EventUtil;
	
	import flash.display.Loader;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.media.Sound;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	
	[Event(name="complete", type="flash.events.Event")]
	[Event(name="init", type="flash.events.Event")]
	[Event(name="open", type="flash.events.Event")]
	[Event(name="unload", type="flash.events.Event")]
	[Event(name="httpStatus", type="flash.events.HTTPStatusEvent")]
	[Event(name="ioError", type="flash.events.IOErrorEvent")]
	[Event(name="progress", type="flash.events.ProgressEvent")]
	public class ResourceLoader extends EventDispatcher implements IResource
	{
		private var _url:String
		
		private var _urlVariables:URLVariables
		
		private var _id:String
		
		private var _content:*
		
		private var _isLoading:Boolean = false
		
		private var _isLoaded:Boolean = false
		
		private var _hasFailed:Boolean = false
		
		private var _loader:Loader
		
		private var _failure:Error
		
		public function ResourceLoader(url:String, urlVariables:URLVariables=null, id:String = null)
		{
			_url = url
			_urlVariables = urlVariables
			
			if (id == null)
			{
				id = url
			}
			
			_id = id
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
			
			EventUtil.addListenerForAll(sound, eventTypes, passOnEvent)
			
			sound.load(new URLRequest(url))
		}
		
		private function loadTextResource(url:String):void
		{
			var urlLoader:URLLoader = new URLLoader()
			
			var errorEventTypes:Array =[IOErrorEvent.IO_ERROR, SecurityErrorEvent.SECURITY_ERROR]
			
			var eventTypes:Array = errorEventTypes.concat([
				Event.ACTIVATE, Event.DEACTIVATE, Event.INIT, 
				Event.OPEN, Event.UNLOAD, HTTPStatusEvent.HTTP_STATUS, ProgressEvent.PROGRESS
			])
			
			urlLoader.addEventListener
			(
				Event.COMPLETE,
				function (event:Event):void 
				{
					_content = urlLoader.data
					passOnEvent(event)
				}
			)
			
			EventUtil.addListenerForAll(urlLoader, eventTypes, passOnEvent)
			EventUtil.addListenerForAll(urlLoader, errorEventTypes, onError)
			
			var urlRequest:URLRequest = new URLRequest(url) 
			
			if (_urlVariables != null)
			{
				urlRequest.data = _urlVariables
			}
			
			urlLoader.load(urlRequest)
		}
		
		private function loadBinaryResource(url:String):void
		{
			_loader = new Loader()
			
			var eventTypes:Array = 
			[
				Event.ACTIVATE, Event.DEACTIVATE, Event.INIT, 
				Event.OPEN, Event.UNLOAD, HTTPStatusEvent.HTTP_STATUS, 
				IOErrorEvent.IO_ERROR, ProgressEvent.PROGRESS
			]
			
			_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onError)
			
			_loader.contentLoaderInfo.addEventListener
			(
				Event.COMPLETE,
				function (event:Event):void 
				{
					_content = _loader.contentLoaderInfo.content
					passOnEvent(event)
				}
			)
			
			EventUtil.addListenerForAll(_loader.contentLoaderInfo, eventTypes, passOnEvent)
			
			_loader.load(new URLRequest(url))
		}
		
		private function onError(event:ErrorEvent):void
		{
			_failure = new Error(event.text)
		}
		
		protected function get loader():Loader
		{
			return _loader
		}
		
		public function get url():String
		{
			return _url
		}
		
		public function get content():*
		{
			return _content
		}
		
		public function get id():String
		{
			return _id
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
			return _failure
		}
		
		private function passOnEvent(event:Event):void
		{
			dispatchEvent(event)
		}
		
		override public function toString():String
		{
			return "[ResourceLoader url=" + _url + "]"
		}
	}
}
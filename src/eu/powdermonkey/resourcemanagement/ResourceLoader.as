package eu.powdermonkey.resourcemanagement
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SampleDataEvent;
	import flash.media.Sound;
	import flash.net.URLRequest;

	public class ResourceLoader extends EventDispatcher
	{
		private var _url:String
		
		private var _loader:Loader
		
		private var _sound:Sound
		
		public function ResourceLoader(url:String)
		{
			_url = url
		}
		
		private function isURLAudio(url:String):Boolean
		{
			return url.search(/\.mp3$/) >= 0
		}
		
		public function load():void
		{
			if (isURLAudio(url))
			{
				_sound = new Sound()
				_sound.addEventListener(Event.ACTIVATE, passOnEvent)
				_sound.addEventListener(Event.COMPLETE, passOnEvent)
				_sound.addEventListener(Event.DEACTIVATE, passOnEvent)
				_sound.addEventListener(Event.ID3, passOnEvent)
				_sound.addEventListener(Event.OPEN, passOnEvent)
				_sound.addEventListener(IOErrorEvent.IO_ERROR, passOnEvent)
				_sound.addEventListener(ProgressEvent.PROGRESS, passOnEvent)
				_sound.addEventListener(SampleDataEvent.SAMPLE_DATA, passOnEvent)
				_sound.load(new URLRequest(_url))
			}
			else
			{
				_loader = new Loader()
				_loader.contentLoaderInfo.addEventListener(Event.ACTIVATE, passOnEvent)
				_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, passOnEvent)
				_loader.contentLoaderInfo.addEventListener(Event.DEACTIVATE, passOnEvent)
				_loader.contentLoaderInfo.addEventListener(Event.INIT, passOnEvent)
				_loader.contentLoaderInfo.addEventListener(Event.OPEN, passOnEvent)
				_loader.contentLoaderInfo.addEventListener(Event.UNLOAD, passOnEvent)
				_loader.contentLoaderInfo.addEventListener(HTTPStatusEvent.HTTP_STATUS, passOnEvent)
				_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, passOnEvent)
				_loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, passOnEvent)
				_loader.load(new URLRequest(_url))
			}
		}
		
		public function get url():String
		{
			return _url
		}
		
		public function get content():*
		{
			if (_sound != null)
			{
				return _sound
			}
			else
			{
				return _loader.contentLoaderInfo.content
			}
		}
		
		private function passOnEvent(event:Event):void
		{
			dispatchEvent(event)
		}
	}
}
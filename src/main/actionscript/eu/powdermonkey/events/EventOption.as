package eu.powdermonkey.events
{
	import __AS3__.vec.Vector;
	
	import flash.events.IEventDispatcher;
	import flash.events.Event;
	
	public class EventOption
	{
		private var _options:Vector.<EventRegistration> = new Vector.<EventRegistration>
		
		public function addOption(eventDispatcher:IEventDispatcher, listenForType:String, callback:Function):EventOption
		{
			var registration:EventRegistration = new EventRegistration(
				eventDispatcher,
				listenForType,
				callback,
				false
			)
			
			_options.push(registration)
			
			eventDispatcher.addEventListener(
				listenForType,
				function (event:Event):void 
				{
					removeAllListeners()
					callback(event)
				} 
			)
			
			return this
		}
		
		private function removeAllListeners():void
		{
			for each (var reg:EventRegistration in _options)
			{
				reg.removeListener()
			}
		}
	}
}

import flash.events.IEventDispatcher;

class EventRegistration
{
	private var _dispatcher:IEventDispatcher
	private var _type:String
	private var _callback:Function 
	private var _useCapture:Boolean
	
	public function EventRegistration(dispatcher:IEventDispatcher, type:String, callback:Function, useCapture:Boolean)
	{
		_dispatcher = dispatcher
		_type = type
		_callback = callback
		_useCapture = useCapture
	}
	
	public function removeListener():void
	{
		_dispatcher.removeEventListener(_type, _callback, _useCapture)
	}
	
	public function get dispatcher():IEventDispatcher
	{
		return _dispatcher
	}
	
	public function get type():String 
	{
		return _type
	}
	
	public function get callback():Function 
	{
		return _callback
	}
	
	public function get useCapture():Boolean 
	{
		return _useCapture
	}
}
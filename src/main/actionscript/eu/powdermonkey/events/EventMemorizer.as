package eu.powdermonkey.events
{
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	
	public class EventMemorizer implements IEventDispatcher
	{
		private var _eventRegistrations:Array = new Array()
		
		private var _target:IEventDispatcher
		
		public function EventMemorizer(target:IEventDispatcher)
		{
			_target = target
		}
		
		public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void
		{
			_eventRegistrations.push(new EventRegistration(type, listener, useCapture))
			_target.addEventListener(type, listener, useCapture, priority, useWeakReference)
		}
		
		public function dispatchEvent(event:Event):Boolean
		{
			return _target.dispatchEvent(event)
		}
		
		public function hasEventListener(type:String):Boolean
		{
			return _target.hasEventListener(type)	
		}
		
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void
		{
			_target.removeEventListener(type, listener, useCapture)	
		}
		
		public function removeAllEventListeners():void
		{
			for each (var reg:EventRegistration in _eventRegistrations)
			{
				_target.removeEventListener(reg.type, reg.callback, reg.useCapture)
			}
			
			_eventRegistrations = []
		}
		
		public function willTrigger(type:String):Boolean
		{
			return _target.willTrigger(type)
		}
	}
}

class EventRegistration
{
	private var _type:String
	private var _callback:Function 
	private var _useCapture:Boolean
	
	public function EventRegistration(type:String, callback:Function, useCapture:Boolean)
	{
		_type = type
		_callback = callback
		_useCapture = useCapture
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
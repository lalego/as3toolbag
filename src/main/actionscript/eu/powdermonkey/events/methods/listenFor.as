package eu.powdermonkey.events.methods
{
	import flash.events.IEventDispatcher;
	
	public function listenFor(
						type:String, 
						callback:Function, 
						useCapture:Boolean=false, 
						priority:int=0, 
						useWeakReference:Boolean=false
					):Function
	{
		return function (element:IEventDispatcher):void
		{
			element.addEventListener(type, callback, useCapture, priority, useWeakReference)
		}
	}
}
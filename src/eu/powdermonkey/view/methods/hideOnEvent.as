package eu.powdermonkey.view.methods
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	public function hideOnEvent(displayObject:DisplayObject):Function
	{
		return function (event:Event):void
		{
			hide(displayObject)
		}
	}
}

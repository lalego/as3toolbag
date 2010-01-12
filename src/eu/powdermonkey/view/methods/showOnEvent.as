package eu.powdermonkey.view.methods
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	public function showOnEvent(displayObject:DisplayObject):Function
	{
		return function (event:Event):void
		{
			show(displayObject)
		}
	}
}

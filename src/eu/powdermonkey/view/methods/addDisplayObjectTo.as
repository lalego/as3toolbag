package eu.powdermonkey.view.methods
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	
	public function addDisplayObjectTo(container:DisplayObjectContainer):Function
	{
		return function (object:DisplayObject):void
		{
			container.addChild(object)
		}
	}
}
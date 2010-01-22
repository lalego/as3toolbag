package eu.powdermonkey.view.methods
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	
	public function addDisplayObjectHiddenTo(container:DisplayObjectContainer):Function
	{
		return function (object:DisplayObject):void
		{
			hide(object)
			container.addChild(object)
		}
	}
}
package eu.powdermonkey.view.methods
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;
	
	public function addDisplayObjectHiddenAt(container:DisplayObjectContainer, position:Point):Function
	{
		return function (object:DisplayObject):void
		{
			object.visible = false
			object.x = position.x
			object.y = position.y
			container.addChild(object)
		}
	}
}
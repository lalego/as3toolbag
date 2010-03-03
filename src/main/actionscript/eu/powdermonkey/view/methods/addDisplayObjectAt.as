package eu.powdermonkey.view.methods
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;
	
	public function addDisplayObjectAt(container:DisplayObjectContainer, position:Point):Function
	{
		return function (object:DisplayObject):void
		{
			object.x = position.x
			object.y = position.y
			container.addChild(object)
		}
	}
}
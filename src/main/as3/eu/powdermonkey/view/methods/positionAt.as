package eu.powdermonkey.view.methods
{
	import flash.display.DisplayObject;
	import flash.geom.Point;
	
	public function positionAt(position:Point):Function
	{
		return function (object:DisplayObject):void
		{
			object.x = position.x
			object.y = position.y
		}
	}
}
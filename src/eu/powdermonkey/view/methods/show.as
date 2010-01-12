package eu.powdermonkey.view.methods
{
	import eu.powdermonkey.view.IShowable;
	import flash.display.DisplayObject;
	
	public function show(object:DisplayObject):void
	{
		if (object is IShowable)
		{
			IShowable(object).show()
		}
		else
		{
			object.visible = true
		}
	}
}

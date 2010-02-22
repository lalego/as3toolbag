package eu.powdermonkey.view.methods
{
	import eu.powdermonkey.view.IShowable;
	import flash.display.DisplayObject;
	
	public function hide(object:DisplayObject):void
	{
		if (object is IShowable)
		{
			IShowable(object).hide()
		}
		else
		{
			object.visible = false
		}
	}
}
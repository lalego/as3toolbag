package eu.powdermonkey.view.methods
{
	import eu.powdermonkey.view.StackBuilderVertical;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	
	public function stackBottomToTop(container:DisplayObjectContainer, padding:int=0, heightOverride:uint=0):Function
	{
		var stacker:StackBuilderVertical = new StackBuilderVertical(
			StackBuilderVertical.BOTTOM_TO_TOP, 
			padding, 
			heightOverride
		)
		
		return function (object:DisplayObject):void
		{
			container.addChild(stacker.applyNextPosition(object))
		}
	}
}

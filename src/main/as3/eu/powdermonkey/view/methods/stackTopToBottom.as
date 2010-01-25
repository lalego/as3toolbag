package eu.powdermonkey.view.methods
{
	import eu.powdermonkey.view.StackBuilderVertical;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	
	public function stackTopToBottom(container:DisplayObjectContainer, padding:int=0, heightOverride:uint=0):Function
	{
		var stacker:StackBuilderVertical = new StackBuilderVertical(
			StackBuilderVertical.TOP_TO_BOTTOM, 
			padding, 
			heightOverride
		)
		
		return function (object:DisplayObject):void
		{
			container.addChild(stacker.applyNextPosition(object))
		}
	}
}

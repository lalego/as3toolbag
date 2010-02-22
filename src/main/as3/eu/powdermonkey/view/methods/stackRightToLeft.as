package eu.powdermonkey.view.methods
{
	import eu.powdermonkey.view.StackBuilderHorizontal;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	
	public function stackRightToLeft(container:DisplayObjectContainer, padding:int=0, heightOverride:uint=0):Function
	{
		var stacker:StackBuilderHorizontal = new StackBuilderHorizontal(
			StackBuilderHorizontal.RIGHT_TO_LEFT, 
			padding, 
			heightOverride
		)
		
		return function (object:DisplayObject):void
		{
			container.addChild(stacker.applyNextPosition(object))
		}
	}
}

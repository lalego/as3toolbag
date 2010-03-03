package eu.powdermonkey.view.methods
{
	import flash.display.DisplayObjectContainer;
	
	public function forAllChildren(container:DisplayObjectContainer, callback:Function):void
	{
		for (var i:int; i<container.numChildren; ++i)
		{
			callback(container.getChildAt(i), i, container.numChildren)
		}
	}
}
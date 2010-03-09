package eu.powdermonkey.view
{
	import eu.powdermonkey.module_access;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	
	public class DepthSorter
	{
		use namespace module_access
		
		module_access var container:DisplayObjectContainer
		module_access var moveable:DisplayObject
		
		public function DepthSorter(container:DisplayObjectContainer)
		{
			this.container = container
		}
		
		public function move(moveable:DisplayObject):Action
		{
			validate(moveable)
			this.moveable = moveable
			return new Action(this)
		}
		
		module_access function validate(candidate:DisplayObject):void
		{
			if (candidate in container) 
				throw new ArgumentError(candidate + " is not a member of the container " + container)
		}
	}
}

import flash.display.DisplayObject;
import eu.powdermonkey.view.DepthSorter;
import eu.powdermonkey.module_access;
	
class Action 
{
	use namespace module_access
	
	private var _depthSorter:DepthSorter
	
	public function Action(depthSorter:DepthSorter)
	{
		_depthSorter = depthSorter
	}
	
	public function toIndex(index:int):void
	{
		_depthSorter.container.setChildIndex(_depthSorter.moveable, index)
	}
	
	public function behindOf(pivot:DisplayObject):void
	{
		_depthSorter.validate(pivot)
		var index:int = getIndex(pivot)
		var newIndex:int = index > 0 ? index - 1 : 0  
		toIndex(newIndex)
	}
	
	public function infrontOf(pivot:DisplayObject):void
	{
		_depthSorter.validate(pivot)
		var lastIndex:int = _depthSorter.container.numChildren - 1
		var index:int = getIndex(pivot)
		var newIndex:int = index < lastIndex ? index + 1 : lastIndex
		toIndex(newIndex)
	}
	
	private function getIndex(view:DisplayObject):int
	{
		return _depthSorter.container.getChildIndex(view)
	}
}
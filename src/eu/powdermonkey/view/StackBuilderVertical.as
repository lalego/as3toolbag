package eu.powdermonkey.view
{
	import flash.display.DisplayObject;
	
	public class StackBuilderVertical
	{
		public static const TOP_TO_BOTTOM:int = -1
		
		public static const BOTTOM_TO_TOP:int = 1
		
		private var direction:int
		
		private var _offset:int = 0
		
		private var padding:int
		
		private var heightOverride:uint
		
		
		public function StackBuilderVertical(direction:int=-1, padding:int=0, heightOverride:uint=0)
		{
			this.direction = direction
			this.padding = padding
			this.heightOverride = heightOverride
		}
		
		
		public function applyNextPosition(element:DisplayObject):DisplayObject
		{
			if (isDirectionTopToBottom())
			{
				element.y = _offset
				nextOffset(element)
			}
			else
			{
				nextOffset(element)
				element.y = _offset
			}
			
			return element
		}
		
		private function nextOffset(element:DisplayObject):void
		{
			if (heightOverride > 0)
			{
				incrementOffset(heightOverride + padding)
			}
			else
			{
				incrementOffset(element.height + padding)
			}
		}
		
		private function get offset():int
		{
			return _offset
		}
		
		
		private function incrementOffset(value:int):void
		{
			if (isDirectionTopToBottom())
			{
				_offset += value
			}
			else
			{
				_offset -= value
			}
		}
		
		
		private function isDirectionTopToBottom():Boolean
		{
			return direction < 0
		}
	}		
}
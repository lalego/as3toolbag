package eu.powdermonkey.view
{
	import flash.display.DisplayObject;
	
	public class StackBuilderHorizontal
	{
		public static const LEFT_TO_RIGHT:int = 1
		
		public static const RIGHT_TO_LEFT:int = -1
		
		private var direction:int
		
		private var _offset:int = 0
		
		private var padding:int
		
		private var widthOverride:uint
		
		
		public function StackBuilderHorizontal(direction:int=-1, padding:int=0, widthOverride:uint=0)
		{
			this.direction = direction
			this.padding = padding
			this.widthOverride = widthOverride
		}
		
		
		public function applyNextPosition(element:DisplayObject):DisplayObject
		{
			if (isDirectionTopToBottom())
			{
				element.x = _offset
				nextOffset(element)
			}
			else
			{
				nextOffset(element)
				element.x = _offset
			}
			
			return element
		}
		
		private function nextOffset(element:DisplayObject):void
		{
			if (widthOverride > 0)
			{
				incrementOffset(widthOverride + padding)
			}
			else
			{
				incrementOffset(element.width + padding)
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
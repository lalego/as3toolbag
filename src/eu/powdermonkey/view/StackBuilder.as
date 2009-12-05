package eu.powdermonkey.view
{
	import flash.display.DisplayObject;
	
	public class StackBuilder
	{
		public static const TOP_TO_BOTTOM:int = -1
		
		public static const BOTTOM_TO_TOP:int = 1
		
		private var _direction:int
		
		private var _offset:int
		
		private var _padding:int
		
		private var _heightConst:uint
		
		
		public function StackBuilder(direction:int=-1, offset:int=0, padding:int=0, heightConst:uint=0)
		{
			_direction = direction
			_offset = offset
			_padding = padding
			_heightConst = heightConst
		}
		
		
		public function positionElement(element:DisplayObject):DisplayObject
		{
			if (isDirectionTopToBottom())
			{
				element.y = getOffset()
				nextOffset(element)
			}
			else
			{
				nextOffset(element)
				element.y = getOffset()
			}
			
			return element
		}
		
		private function nextOffset(element:DisplayObject):void
		{
			if (_heightConst > 0)
			{
				incrementOffset(_heightConst + _padding)
			}
			else
			{
				incrementOffset(element.height + _padding)
			}
		}
		
		private function getOffset():int
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
			return _direction < 0
		}
	}		
}
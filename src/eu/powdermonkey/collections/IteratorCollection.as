package eu.powdermonkey.collections
{
	public class IteratorCollection implements IIterator
	{
		private var _iteratorList:Array /* of IIterator */ = []
		
		private var _index:int = 0
		
		private var _depthList:Array = []
		
		
		public function IteratorCollection(iteratorList:Array /* of IIterator */ = null)
		{
			if (iteratorList != null)
			{
				_iteratorList = iteratorList.concat()
			}
		}
		
		public function addIterator(iterator:IIterator):void
		{
			_iteratorList.push(iterator)
		}
		
		public function addIterators(iteratorList:Array /* of IIterator */):void
		{
			_iteratorList = _iteratorList.concat(iteratorList)
		}
		
		public function get hasNext():Boolean
		{
			if (currentIterator == null)
			{
				return _index < _iteratorList.length
			}
			else
			{
				return currentIterator.hasNext 
			}
		}
		
		public function next():*
		{
			var nextIterator:IIterator
			
			if (_depthList.length == 0)
			{
				nextIterator = _iteratorList[_index]
			}
			else
			{
				nextIterator = _depthList.pop()
			}
			
//			nextIterator = _iteratorList[_index]
			
			var nextElement:* = getNextValue(nextIterator, 0)
			
			if (nextIterator.hasNext == false)
			{
				_index++
			}
			
			return nextElement
		}
		
		private function getNextValue(iterator:IIterator, depth:int):*
		{
			var nextValue:* = null
			
			if (iterator.hasNext)
			{
				nextValue = iterator.next()
				
				if (nextValue is IIterator)
				{
					_depthList.push(nextValue)
					nextValue = getNextValue(nextValue as IIterator, ++depth)
				}
			}
			  
			return nextValue
		}
			
		private function get currentIterator():IIterator
		{
			return _depthList[_depthList.length - 1]
		}
	}
}
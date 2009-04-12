package eu.powdermonkey.collections
{
	import flash.utils.Proxy
	import flash.utils.flash_proxy;
	
	public class ArrayIterator extends Proxy implements IIterator
	{
		private var _collection:Array = []
		
		private var _index:uint = 0
		
		
		public function ArrayIterator(collection:Array)
		{
			_collection = collection
		}
		
		//-----------------------------------------------------
		
		public function get hasNext():Boolean
		{
			return _index < _collection.length
		}
		
		public function next():*
		{
			var nextElement:* = _collection[_index]
			_index++
			return nextElement
		}
			
		//-----------------------------------------------------
		
		override flash_proxy function nextNameIndex (index:int):int
		{
			if (index < _collection.length) 
			{
				return index + 1
			}
			else
			{
				return 0
			}
		}		
		
		override flash_proxy function nextValue(index:int):*
		{
			return _collection[index - 1]		
		}
		
		//-----------------------------------------------------
		
		public function toString():String
		{
			return '[ArrayIterator]'
		}
	}
}
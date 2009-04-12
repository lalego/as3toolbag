package eu.powdermonkey.collections
{
	import __AS3__.vec.Vector;
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;

	public class VectorIterator extends Proxy implements IIterator
	{
		private var _collection:Vector.<Object> = new Vector.<Object>()
		
		private var _index:uint = 0
		
		public function VectorIterator(vector:Vector.<Object>)
		{
			_collection = vector
		}
		
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
			return '[VectorIterator]'
		}
	}
}
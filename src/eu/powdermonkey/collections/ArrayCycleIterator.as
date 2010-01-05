package eu.powdermonkey.collections
{
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;
	
	public class ArrayCycleIterator extends Proxy implements IIterator
	{
		private var collection:Array
		
		private var expandedCollectionLength:int
		
		private var indexIncrementer:IIterator
		
		private var cycleIncrementer:Incrementer
		
		private var incrementCycle:Function
		
		public function ArrayCycleIterator(collection:Array, cycles:int=0)
		{
			this.collection = collection
			indexIncrementer = new Incrementer(collection.length)
			cycleIncrementer = new Incrementer(cycles)
			expandedCollectionLength = collection.length * cycles
		}

		public function get hasNext():Boolean
		{
			return indexIncrementer.hasNext
		}
		
		public function next():*
		{
			var nextElement:* = collection[indexIncrementer.next()]
			incrementIndex()
			return nextElement 
		}
		
		public function cloneReset():IIterator
		{
			return new ArrayCycleIterator(collection, cycleIncrementer.max)
		}
		
		private function incrementIndex():void
		{
			if (!indexIncrementer.hasNext)
			{
				if (cycleIncrementer.hasNext)
				{
					cycleIncrementer.next()
					indexIncrementer = indexIncrementer.cloneReset()
				}
			}
		}
		
		override flash_proxy function nextNameIndex(index:int):int
		{
			if (index < expandedCollectionLength) 
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
			return collection[index - 1]		
		}
	}
}
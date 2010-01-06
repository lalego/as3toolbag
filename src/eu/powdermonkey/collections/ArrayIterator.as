package eu.powdermonkey.collections
{
	import eu.powdermonkey.collections.methods.*;
	
	import flash.utils.Dictionary;
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;	
	
	public class ArrayIterator extends Proxy implements IList
	{
		private var collection:Array = []
		
		private var index:uint = 0
		
		public function ArrayIterator(collection:Array)
		{
			this.collection = collection
		}
		
		public function get hasNext():Boolean
		{
			return index < collection.length
		}
		
		public function next():*
		{
			var nextElement:* = collection[index]
			index++
			return nextElement
		}
		
		public function cloneReset():IIterator
		{
			return new ArrayIterator(collection)
		}
		
		override flash_proxy function nextNameIndex(index:int):int
		{
			if (index < collection.length) 
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
		
		public function get head():*
		{
			return collection[0]
		}
		
		public function get tail():IList
		{
			return new ArrayIterator(collection.slice(1))
		}
		
		public function map(callback:Function):IList
		{
			return new ArrayIterator(collection.map(mapto(callback)))
		}
		
		public function mapIndexed(callback:Function):IList
		{
			return new ArrayIterator(collection.map(maptoIndexed(callback)))
		}
		
		public function foreach(callback:Function):IList
		{
			collection.forEach(forall(callback))
			return this
		}
		
		public function foreachIndexed(callback:Function):IList
		{
			collection.forEach(forallIndexed(callback))
			return this
		}
		
		public function toDictionary(callback:Function):Dictionary
		{
			var dictionary:Dictionary = new Dictionary()
			
			for each (var child:Object in collection)
			{
				var mapping:Object = callback(child)
				dictionary[mapping.key] = mapping.value
			}
			
			return dictionary
		}
		
		public function toXMLList():XMLList
		{
			var xml:XML = new XML(<collection></collection>)
			
			for each (var child:Object in collection)
			{
				if (child.hasOwnProperty('toXML'))
				{
					xml.appendChild(child.toXML())
				}
				else
				{
					xml.appendChild(child)
				}
			}
			
			return xml.*
		}
		
		public function toString():String
		{
			return collection.toString()
		}
	}
}
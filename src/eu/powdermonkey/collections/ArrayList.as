package eu.powdermonkey.collections
{
	import eu.powdermonkey.collections.methods.*;
	import eu.powdermonkey.maths.methods.*;
	
	import flash.utils.Dictionary;
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;	
	
	public class ArrayList extends Proxy implements IList
	{
		private var collection:Array = []
		
		private var index:uint = 0
		
		public function ArrayList(collection:Array)
		{
			this.collection = collection
		}
		
		public function get length():int
		{
			return collection.length
		}
		
		public function get hasNext():Boolean
		{
			return index < length
		}
		
		public function next():*
		{
			var nextElement:* = collection[index]
			index++
			return nextElement
		}
		
		public function cloneReset():IIterator
		{
			return new ArrayList(collection)
		}
		
		override flash_proxy function getProperty(name:*):*
		{
			return collection[name]
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
			return new ArrayList(collection.slice(1))
		}
		
		public function map(eachElementCallback:Function):IList
		{
			return new ArrayList(mapToArray(eachElementCallback))
		}
		
		public function mapToArray(eachElementCallback:Function):Array
		{
			return collection.map(mapto(eachElementCallback))
		}
		
		public function mapIndexed(eachElementCallback:Function):IList
		{
			return new ArrayList(mapIndexedToArray(eachElementCallback))
		}
		
		public function mapIndexedToArray(eachElementCallback:Function):Array
		{
			return collection.map(maptoIndexed(eachElementCallback))
		}
		
		public function foreach(eachElementCallback:Function):IList
		{
			collection.forEach(forall(eachElementCallback))
			return this
		}
		
		public function foreachIndexed(eachElementCallback:Function):IList
		{
			collection.forEach(forallIndexed(eachElementCallback))
			return this
		}
		
		public function random():*
		{
			var index:int = floor(Math.random() * (collection.length - 1))
			return collection[index]
		}
		
		public function toMap(mappingCallback:Function):IMap
		{
			return new Map(toDictionary(mappingCallback))
		}
		
		public function toDictionary(mappingCallback:Function):Dictionary
		{
			var dictionary:Dictionary = new Dictionary()
			
			for each (var child:* in collection)
			{
				var mapping:Object = mappingCallback(child)
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
		
		public function toArray():Array
		{
			return collection.concat()
		}
		
		public function toString():String
		{
			return collection.toString()
		}
	}
}
package eu.powdermonkey.collections
{
	import eu.powdermonkey.collections.methods.*;
	import eu.powdermonkey.maths.methods.*;
	
	import flash.utils.Dictionary;
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;	
	
	public class XMLArrayList extends Proxy implements IList
	{
		private var collection:XMLList
		
		private var array:Array = []
		
		private var index:uint = 0
		
		public function XMLArrayList(xmlList:XMLList)
		{
			this.collection = xmlList
			
			for each (var child:XML in collection)
			{
				array.push(child)
			}
		}
		
		public function get length():int
		{
			return collection.length()
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
			return new XMLArrayList(collection)
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
			return new ArrayList(array.slice(1))
		}
		
		public function map(eachElementCallback:Function):IList
		{
			return new ArrayList(mapToArray(eachElementCallback))
		}
		
		public function mapToArray(eachElementCallback:Function):Array
		{
			var array:Array = []
			
			for each(var element:XML in collection)
			{
				array.push(eachElementCallback(element))
			}
			
			return array
		}
		
		public function mapIndexed(eachElementCallback:Function):IList
		{
			return new ArrayList(mapIndexedToArray(eachElementCallback))
		}
		
		public function mapIndexedToArray(eachElementCallback:Function):Array
		{
			var array:Array = []
			var index:int = 0
			
			for each(var element:XML in collection)
			{
				array.push(eachElementCallback(element, index++, length))
			}
			
			return array
		}
		
		public function foreach(eachElementCallback:Function):IList
		{
			for each(var element:XML in collection)
			{
				foreach(eachElementCallback)
			}
			return this
		}
		
		public function foreachIndexed(eachElementCallback:Function):IList
		{
			for each(var element:XML in collection)
			{
				foreachIndexed(eachElementCallback)
			}
			return this
		}
		
		public function random():*
		{
			var index:int = floor(Math.random() * (array.length - 1))
			return array[index]
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
			return collection.copy()
		}
		
		public function toString():String
		{
			return collection.toString()
		}
		
		public function toArray():Array
		{
			return array.concat()
		}
	}
}
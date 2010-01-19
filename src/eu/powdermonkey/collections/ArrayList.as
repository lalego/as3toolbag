package eu.powdermonkey.collections
{
	import eu.powdermonkey.collections.methods.*;
	import eu.powdermonkey.maths.methods.*;
	
	import flash.utils.Dictionary;
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;	
	
	public class ArrayList extends Proxy implements IList
	{
		public static const Empty:IList = new ArrayList([])
		
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
		
		public function filter(eachElementPredicate:Function):IList
		{
			return new ArrayList(collection.filter(filterto(eachElementPredicate)))
		}
		
		public function filterMap(eachElementPredicate:Function):IList
		{
			var included:Array = []
			
			for each (var element:* in collection)
			{
				var newObject:* = eachElementPredicate(element)
				if (newObject)
				{
					included.push(newObject)
				}
			}
			
			return new ArrayList(included)
		}
		
		public function partition(eachElementPredicate:Function):IPair
		{
			var satisfied:Array = []
			var unsatisfied:Array = []
			
			for each (var element:* in collection)
			{
				if (eachElementPredicate(element))
				{
					satisfied.push(element)
				}
				else
				{
					unsatisfied.push(element)
				}
			}
			
			return new Pair(new ArrayList(satisfied), new ArrayList(unsatisfied))
		}
		
		public function takeWhile(eachElementPredicate:Function):IList
		{
			var taken:Array = []
			
			for each (var element:* in collection)
			{
				if (eachElementPredicate(element))
				{
					taken.push(element)
				}
				else
				{
					break
				}
			}
			
			return new ArrayList(taken)
		}
		
		public function concat(list:IList):IList
		{
			var listArray:Array = list.toArray()
			return new ArrayList(collection.concat(listArray))
		}
		
		public function join(sep:*):String
		{
			return collection.join(sep)
		}
		
		public function random():*
		{
			var index:int = floor(Math.random() * (collection.length - 1))
			return collection[index]
		}
		
		public function slice(startIndex:int = 0, endIndex:int = 16777215):IList
		{
			return new ArrayList(collection.slice(startIndex, endIndex))
		}
		
		public function toMap(mappingCallback:Function):IMap
		{
			return new Map(toDictionary(mappingCallback))
		}
		
		public function toMapIndexed(mappingCallback:Function):IMap
		{
			return new Map(toDictionaryIndexed(mappingCallback))
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
		
		public function toDictionaryIndexed(mappingCallback:Function):Dictionary
		{
			var dictionary:Dictionary = new Dictionary()
			var index:int = 0
			
			for each (var child:* in collection)
			{
				var mapping:Object = mappingCallback(child, index++, collection.length)
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
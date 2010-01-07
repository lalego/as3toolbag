package eu.powdermonkey.collections
{
	import flash.utils.Dictionary;
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;
		
	public class Map extends Proxy implements IMap
	{
		public static const Empty:IMap = new Map(new Dictionary())
		
		private var dictionary:Dictionary
		
		private var valueToKey:Dictionary = new Dictionary()
		
		private var _keys:ArrayList
		
		private var _values:ArrayList
		
		private var index:uint = 0
		
		public function Map(dictionary:Dictionary)
		{
			this.dictionary = dictionary
			
			var keys:Array = []
			var values:Array = []
			
			for (var key:* in dictionary)
			{
				var value:* = dictionary[key] 
				keys.push(key)
				values.push(value)
				valueToKey[key] = value
			}
			
			_keys = new ArrayList(keys)
			_values = new ArrayList(values)
		}
		
		public function get length():int
		{
			return _keys.length
		}
		
		public function get hasNext():Boolean
		{
			return index < length
		}
		
		public function next():*
		{
			return _values.next()
		}
		
		public function cloneReset():IIterator
		{
			return new Map(dictionary)
		}
		
		override flash_proxy function getProperty(name:*):*
		{
			throw new Error('[] operator cannot be implemented, use function get value(key:*):* instead')
		}
		
		override flash_proxy function setProperty(name:*, value:*):void
		{
			throw new Error('[] operator cannot be implemented, use function get value(key:*):* instead')
		}
		
		override flash_proxy function nextNameIndex(index:int):int
		{
			if (index < length) 
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
			use namespace flash_proxy
			return _values.nextValue(index)
		}
		
		public function value(key:*):*
		{
			return dictionary[key]
		}
		
		public function key(value:*):*
		{
			return valueToKey[value]
		}
		
		public function get keys():IList
		{
			return IList(_keys.cloneReset())
		}
		
		public function get head():*
		{
			return _values.head
		}
		
		public function get tail():IList
		{
			return _values.tail
		}
		
		public function map(callback:Function):IList
		{
			var newDictionary:Dictionary = new Dictionary() 
			
			for (var key:* in dictionary)
			{
				var pair:Object = {key:key, value:dictionary[key]} 
				var newPair:Object = callback(pair)
				newDictionary[newPair.key] = newPair.value
			}
			
			return new Map(newDictionary)
		}
		
		public function mapIndexed(callback:Function):IList
		{
			var newDictionary:Dictionary = new Dictionary() 
			var index:int = 0
			
			for (var key:* in dictionary)
			{
				var pair:Object = {key:key, value:dictionary[key]} 
				var newPair:Object = callback(pair, index++, length)
				newDictionary[newPair.key] = newPair.value
			}
			
			return new Map(newDictionary)
		}
		
		public function foreach(eachPairCallback:Function):IList
		{
			for (var key:* in dictionary)
			{
				var pair:Object = {key:key, value:dictionary[key]} 
				eachPairCallback(pair)
			}
			
			return this
		}
		
		public function foreachIndexed(eachPairCallback:Function):IList
		{
			var index:int = 0
			for (var key:* in dictionary)
			{
				var pair:Object = {key:key, value:dictionary[key]} 
				eachPairCallback(pair, index++, length)
			}
			
			return this
		}
		
		public function foreachKey(eachKeyCallback:Function):IList
		{
			for (var key:* in dictionary)
			{
				eachKeyCallback(key)
			}
			
			return this
		}
		
		public function foreachKeyIndexed(eachKeyCallback:Function):IList
		{
			var index:int = 0
			
			for (var key:* in dictionary)
			{
				eachKeyCallback(key, index++, length)
			}
			
			return this
		}
		
		public function foreachValue(eachKeyCallback:Function):IList
		{
			for each(var value:* in dictionary)
			{
				eachKeyCallback(value)
			}
			
			return this
		}
		
		public function foreachValueIndexed(eachKeyCallback:Function):IList
		{
			var index:int = 0
			
			for each(var value:* in dictionary)
			{
				eachKeyCallback(value, index++, length)
			}
			
			return this
		}
		
		public function toMap(mappingCallback:Function):IMap
		{
			return new Map(toDictionary(mappingCallback))
		}
		
		/**
		 * 
		 * @param mappingCallback a function with the parameters with the signiture:
		 * function (key:*, value:*):Object
		 * where the return Object contains a key and value property
		 * @return an Object that contains a key and value property that will 
		 * be mapped to the new dictionary
		 * 
		 */		
		public function toDictionary(mappingCallback:Function):Dictionary
		{
			var dictionary:Dictionary = new Dictionary()
			
			for (var key:* in dictionary)
			{
				var value:* = dictionary[key]
				var mapping:Object = mappingCallback(key, value)
				dictionary[mapping.key] = mapping.value
			}
			
			return dictionary
		}
		
		public function toXMLList():XMLList
		{
			var xml:XML = new XML(<collection></collection>)
			
			for each (var child:Object in dictionary)
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
			return dictionary.toString()
		}
	}
}
package eu.powdermonkey.collections
{
	import eu.powdermonkey.maths.methods.floor;
	
	import flash.utils.Dictionary;
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;	
	
	public class RepeaterList extends Proxy implements IList
	{
		private var value:*
		 
		private var repeatAmount:int
		
		private var index:uint = 0
		
		public function RepeaterList(value:*, repeatAmount:int)
		{
			this.value = value
			this.repeatAmount = repeatAmount
		}
		
		public function next():*
		{
			index++
			return value
		}
		
		public function cloneReset():IIterator
		{
			return new RepeaterList(value, repeatAmount)
		}
		
		override flash_proxy function getProperty(name:*):*
		{
			return value
		}
		
		override flash_proxy function nextNameIndex(index:int):int
		{
			if (index < repeatAmount) 
			{
				return 1
			}
			else
			{
				return 0
			}
		}		
		
		override flash_proxy function nextValue(index:int):*
		{
			return value		
		}
		
		public function get head():*
		{
			return value
		}
		
		public function get hasNext():Boolean
		{
			return index < repeatAmount;
		}
		
		public function get tail():IList
		{
			return new RepeaterList(value, repeatAmount-1)
		}
		
		public function get length():int
		{
			return repeatAmount
		}
		
		public function map(eachPairCallback:Function):IList
		{
			return null;
		}
		
		public function mapToArray(eachPairCallback:Function):Array
		{
			return null;
		}
		
		public function mapIndexed(eachPairCallback:Function):IList
		{
			return null;
		}
		
		public function mapIndexedToArray(eachPairCallback:Function):Array
		{
			return null;
		}
		
		public function foreach(eachElementCallback:Function):IList
		{
			return null;
		}
		
		public function foreachIndexed(eachElementCallback:Function):IList
		{
			return null;
		}
		
		public function filter(eachElementPredicate:Function):IList
		{
			return null;
		}
		
		public function filterMap(eachElementPredicate:Function):IList
		{
			return null;
		}
		
		public function partition(eachElementPredicate:Function):IPair
		{
			return null;
		}
		
		public function takeWhile(eachElementPredicate:Function):IList
		{
			return null;
		}
		
		public function concat(list:IList):IList
		{
			return null;
		}
		
		public function join(sep:*):String
		{
			return null;
		}
		
		public function random():*
		{
			return null;
		}
		
		public function foldLeft(initialValue:*, eachElementAccumulationCallback:Function):*
		{
			return null;
		}
		
		public function reduceLeft(eachElementAccumulationCallback:Function):*
		{
			return null;
		}
		
		public function slice(startIndex:int=0, endIndex:int=16777215):IList
		{
			if (endIndex > repeatAmount) endIndex = repeatAmount
			return new RepeaterList(value, endIndex - startIndex)
		}
		
		public function eachPair():IList
		{
			return new RepeaterList(new Pair(value, value), floor(repeatAmount / 2))
		}
		
		public function eachSlice(amount:int):IList
		{
			return null;
		}
		
		public function toMap(mappingCallback:Function):IMap
		{
			return null;
		}
		
		public function toMapIndexed(mappingCallback:Function):IMap
		{
			return null;
		}
		
		public function toDictionary(mappingCallback:Function):Dictionary
		{
			return null;
		}
		
		public function toDictionaryIndexed(mappingCallback:Function):Dictionary
		{
			return null;
		}
		
		public function toXMLList():XMLList
		{
			var xml:XML = new XML(<collection></collection>)
			var i:int = repeatAmount
			
			if (value.hasOwnProperty('toXML'))
			{
				while (--repeatAmount >= 0)
				{
					xml.appendChild(value.toXML())
				}
			}
			else
			{
				while (--repeatAmount >= 0)
				{
					xml.appendChild(value)
				}
			}
			
			return xml.*
		}
		
		public function toArray():Array
		{
			var values:Array = []
			var i:int = repeatAmount
			while (--repeatAmount >= 0)
			{
				values.push(value)
			}
			
			return values
		}
		
	}
}
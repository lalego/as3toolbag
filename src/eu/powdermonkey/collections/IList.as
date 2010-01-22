package eu.powdermonkey.collections
{
	import flash.utils.Dictionary;
	
	public interface IList extends IIterator
	{
		function get head():*
		
		function get tail():IList
		
		function get length():int
		
		function map(eachPairCallback:Function):IList
		
		function mapToArray(eachPairCallback:Function):Array
		
		function mapIndexed(eachPairCallback:Function):IList
		
		function mapIndexedToArray(eachPairCallback:Function):Array
		
		function foreach(eachElementCallback:Function):IList
		
		function foreachIndexed(eachElementCallback:Function):IList
		
		function filter(eachElementPredicate:Function):IList
		
		function filterMap(eachElementPredicate:Function):IList
		
		function partition(eachElementPredicate:Function):IPair
		
		function takeWhile(eachElementPredicate:Function):IList
		
		function concat(list:IList):IList
		
		function join(sep:*):String
		
		function random():*
		
		function foldLeft(initialValue:*, eachElementAccumulationCallback:Function):*
		
		function reduceLeft(eachElementAccumulationCallback:Function):*
		
		function slice(startIndex:int = 0, endIndex:int = 16777215):IList
		
		function eachPair():IList
		
		function eachSlice(amount:int):IList
		
		function toMap(mappingCallback:Function):IMap
		
		function toMapIndexed(mappingCallback:Function):IMap
		
		function toDictionary(mappingCallback:Function):Dictionary
		
		function toDictionaryIndexed(mappingCallback:Function):Dictionary
		
		function toXMLList():XMLList
		
		function toArray():Array
	}
}
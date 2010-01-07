package eu.powdermonkey.collections
{
	import flash.utils.Dictionary;
	
	public interface IList extends IIterator
	{
		function get head():*
		
		function get tail():IList
		
		function get length():int
		
		function map(eachPairCallback:Function):IList
		
		function mapIndexed(eachPairCallback:Function):IList
		
		function foreach(eachElementCallback:Function):IList
		
		function foreachIndexed(eachElementCallback:Function):IList
		
		function toMap(mappingCallback:Function):IMap
		
		function toDictionary(mappingCallback:Function):Dictionary
		
		function toXMLList():XMLList
	}
}
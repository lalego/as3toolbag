package eu.powdermonkey.collections
{
	import flash.utils.Dictionary;
	
	public interface IList extends IIterator
	{
		function get head():*
		
		function get tail():IList
		
		function map(callback:Function):IList
		
		function mapIndexed(callback:Function):IList
		
		function foreach(callback:Function):IList
		
		function foreachIndexed(callback:Function):IList
		
		function toDictionary(callback:Function):Dictionary
		
		function toXMLList():XMLList
	}
}
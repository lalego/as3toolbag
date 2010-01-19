package eu.powdermonkey.collections
{
	public interface IMap extends IList
	{
		function hasValue(key:*):Boolean
		
		function value(key:*):*
		
		function get values():IList
		
		function hasKey(value:*):Boolean
		
		function key(value:*):*
		
		function get keys():IList
		
		function foreachKey(eachKeyCallback:Function):IList
		
		function foreachKeyIndexed(eachKeyCallback:Function):IList
		
		function foreachValue(eachKeyCallback:Function):IList
		
		function foreachValueIndexed(eachKeyCallback:Function):IList
	}
}
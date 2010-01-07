package eu.powdermonkey.collections
{
	public interface IMap extends IList
	{
		function value(key:*):*
		
		function key(value:*):*
		
		function get keys():IList
		
		function foreachKey(eachKeyCallback:Function):IList
		
		function foreachKeyIndexed(eachKeyCallback:Function):IList
		
		function foreachValue(eachKeyCallback:Function):IList
		
		function foreachValueIndexed(eachKeyCallback:Function):IList
	}
}
package eu.powdermonkey.collections
{
	public interface IListIterator extends IIterator
	{
		function get head():*
		
		function get tail():IListIterator
		
		function map(callback:Function):IListIterator
		
		function mapIndexed(callback:Function):IListIterator
		
		function foreach(callback:Function):IListIterator
		
		function foreachIndexed(callback:Function):IListIterator
	}
}
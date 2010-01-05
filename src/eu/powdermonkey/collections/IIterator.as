package eu.powdermonkey.collections
{
	public interface IIterator
	{
		function get hasNext():Boolean
		
		function next():*
		
		function cloneReset():IIterator
	}
}
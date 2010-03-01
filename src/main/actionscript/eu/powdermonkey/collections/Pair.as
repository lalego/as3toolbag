package eu.powdermonkey.collections
{
	public class Pair implements IPair
	{
		private var _first:*
		 
		private var _second:*
		
		public function Pair(first:*, second:*)
		{
			_first = first
			_second = second
		}
		
		public function get first():*
		{
			return _first
		}
		
		public function get second():*
		{
			return _second
		}
	}
}
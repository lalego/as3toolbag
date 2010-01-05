package eu.powdermonkey.collections
{
	public class Incrementer implements IIterator
	{
		private var _index:int = 0
		
		private var _max:int
		
		public function Incrementer(max:int)
		{
			_max = max
		}
		
		public function get max():int
		{
			return _max
		}
		
		public function get index():int
		{
			return _index
		}
		
		public function get hasNext():Boolean
		{
			return _index < _max
		}
		
		public function cloneReset():IIterator
		{
			return new Incrementer(_max)
		}
		
		public function next():*
		{
			if (hasNext)
			{
				_index++
			}
			
			return _index
		}
		
		public function peekNext():*
		{
			if (hasNext)
			{
				return _index + 1
			}
			else
			{
				return _index
			}
		}
	}
}
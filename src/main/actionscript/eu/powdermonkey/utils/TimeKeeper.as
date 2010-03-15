package eu.powdermonkey.utils
{
	import flash.utils.getTimer;

	public class TimeKeeper
	{
		private var _previousUpdateTime:Number = getTimer()
	
		private var _currentTime:Number = 0
		
		private var _timeDifference:Number = 0
		
		public function update():int
		{
			_currentTime = getTimer()
			_timeDifference = _currentTime - _previousUpdateTime
			_previousUpdateTime = _currentTime
			return _timeDifference
		}
		
		public function get previousUpdateTime():Number
		{
			return _previousUpdateTime
		}
		
		public function get currentTime():Number
		{
			return _currentTime
		}
		
		public function get timeDifferenceMilli():Number
		{
			return _timeDifference
		}
		
		public function get timeDifferenceSecond():Number
		{
			return _timeDifference / 1000
		}
	}
}
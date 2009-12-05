package eu.powdermonkey.utils
{
	import flash.utils.getTimer;

	public class TimeKeeper
	{
		private var _previousUpdateTime:Number = 0
	
		private var _currentTime:Number = 0
		
		private var _timeDifference:Number = 0
		
		public function update():void
		{
			_currentTime = getTimer()
			_timeDifference = _currentTime - _previousUpdateTime
			_previousUpdateTime = _currentTime
		}
		
		public function get previousUpdateTime():Number
		{
			return _previousUpdateTime
		}
		
		public function get currentTime():Number
		{
			return _currentTime
		}
		
		public function get timeDifference():Number
		{
			return _timeDifference
		}
	}
}
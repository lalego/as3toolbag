package eu.powdermonkey.io
{
	import flash.events.Event;

	public class LoadingSequenceProgressEvent extends Event
	{
		public static const PROGRESS:String = 'LoadingSequenceProgressEvent.PROGRESS' 
		
		private var _progress:Number = 0
		
		public function LoadingSequenceProgressEvent(progress:Number)
		{
			super(LoadingSequenceProgressEvent.PROGRESS, false, false)
			_progress = progress
		}
		
		public function get progress():Number
		{
			return _progress
		} 
		
		override public function clone():Event
		{
			return new LoadingSequenceProgressEvent(_progress)
		}	
	}
}
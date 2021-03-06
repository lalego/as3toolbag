package eu.powdermonkey.io
{
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	
	public class SoundResource extends ResourceLoader
	{
		private var _soundChannel:SoundChannel
		
		private var _volume:Number = 1
		
		private var _pan:Number = 0
		
		private var _loopAmount:int = 0
		
		private var _url:String
		
		private var _isPlaying:Boolean = false
		
		private var _isLoaded:Boolean
		
		public function SoundResource(url:String, id:String=null)
		{
			super(url, null, id)
		}			
		
		public function get sound():Sound 
		{
			return content
		}
		
		public function get soundChannel():SoundChannel 
		{
			return _soundChannel
		}
		
		public function get pan():Number 
		{
			return _pan
		}
		
		public function set pan(leftRight:Number):void 
		{
			_pan = leftRight
			
			if (isPlaying)
			{
				updateSoundTransform()	
			}		
		}
		
		private function updateSoundTransform():void
		{
			var transform:SoundTransform = _soundChannel.soundTransform
			
			transform.pan = _pan
			transform.volume = _volume
				
			_soundChannel.soundTransform = transform
		}
		
		public function get volume():Number 
		{
			return _volume
		}
		
		public function set volume(vol:Number):void 
		{
			_volume= vol		
		}
		
		public function get loopAmount():int 
		{
			return _loopAmount
		}
		
		public function set loopAmount(amount:int):void 
		{
			_loopAmount = amount		
		}
		
		public function loopInfinite():void
		{
			_loopAmount = -1
		}
		
		public function get isInfinteLoop():Boolean 
		{
			return _loopAmount<0  
		}
		
		public function get length():Number
		{
			return sound.length
		}
		
		public function play():SoundChannel 
		{
			if (_soundChannel)
			{
				_soundChannel.stop()
				_soundChannel.removeEventListener(Event.SOUND_COMPLETE, onSoundComplete, false)
			}
			
			_soundChannel = sound.play(0, isInfinteLoop ? int.MAX_VALUE : _loopAmount)
			_isPlaying = true 
			_soundChannel.addEventListener(Event.SOUND_COMPLETE, onSoundComplete, false, 0, true)
			
			updateSoundTransform()
			
			return _soundChannel
		}
		
		public function get isPlaying():Boolean
		{
			return _isPlaying
		}
		
		private function onSoundComplete(event:Event):void 
		{
			stop()
			dispatchEvent(new Event(Event.COMPLETE))
		}
		
		public function stop():void
		{
			if (_soundChannel != null)
			{
				_soundChannel.stop()
				_soundChannel = null 
				_isPlaying = false
			}
		}
		
		override public function toString():String 
		{
			return '[SoundResource sound=' + sound + ']'
		}
	}
}
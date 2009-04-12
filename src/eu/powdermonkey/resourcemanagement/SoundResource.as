package eu.powdermonkey.resourcemanagement
{
//	import caurina.transitions.Tweener;
//	import caurina.transitions.properties.SoundShortcuts;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	
	public class SoundResource extends EventDispatcher implements ILoadable
	{
		private var _sound:Sound
		
		private var _soundChannel:SoundChannel
		
		private var _volume:Number = 1
		
		private var _pan:Number = 0
		
		private var _loopAmount:int = 0
		
		private var _url:String
		
		private var _isPlaying:Boolean = false
		
		public function SoundResource(sound:Sound)
		{
			_sound = sound
		}
		
		public function get sound():Sound 
		{
			return _sound
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
			return _sound.length
		}
		
		public function load():void
		{
			_sound.load(new URLRequest(_url))
		}
		
		public function play():SoundChannel 
		{
			_soundChannel = _sound.play(0, isInfinteLoop ? int.MAX_VALUE : _loopAmount)
			_isPlaying = true 
			_soundChannel.addEventListener(Event.SOUND_COMPLETE, onSoundComplete, false, 0, true)
			
			var transform:SoundTransform = _soundChannel.soundTransform		
			
			transform.volume = _volume
			transform.pan = pan
				
			_soundChannel.soundTransform = transform
			
			return _soundChannel
		}
		
//		public function playToVolume(volumeTarget:Number=1, timeMilli:int=1000):void
//		{
//			if (isPlaying == false)
//			{
//				play()
//			}
//			
//			Tweener.addTween
//			(
//				_soundChannel,
//				{
//					_sound_volume: volumeTarget,
//					time: timeMilli / 1000,
//					transition: "linear"
//				}
//			)
//		}
		
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
		
//		public function stopToVolume(volumeTarget:Number=0, timeMilli:int=1000):void
//		{
//			if (isPlaying)
//			{
//				Tweener.addTween
//				(
//					_soundChannel,
//					{
//						_sound_volume: volumeTarget,
//						time: timeMilli / 1000,
//						transition: "linear",
//						onComplete: 
//							function ():void
//							{
//								stop()
//							}
//					}
//				)
//			}
//		}
		
		override public function toString():String 
		{
			return '[SoundResource sound=' + _sound + ']'
		}
	}
}
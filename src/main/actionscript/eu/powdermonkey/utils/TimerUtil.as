package eu.powdermonkey.utils
{
	import flash.events.TimerEvent;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	
	public class TimerUtil extends Timer
	{
		public static const MINUTES_PER_HOUR:Number = 60
		
		public static const MINUTES_PER_DAY:Number = 24 * 60
	
		
		public static const SECONDS_PER_MINUTE:Number = 60
		
		public static const SECONDS_PER_HOUR:Number = 60 * 60
		
		public static const SECONDS_PER_DAY:Number = 60 * 60 * 24
		 
		 
		public static const MILLISECONDS_PER_SECOND:Number = 1000
		 
		public static const MILLISECONDS_PER_MINUTE:Number = 1000 * 60
		
		public static const MILLISECONDS_PER_HOUR:Number = 1000 * 60 * 60
		 
		public static const MILLISECONDS_PER_DAY:Number = 1000 * 60 * 60 * 24
		
		
		private static var activeTimers:Dictionary = new Dictionary()
		
		public function TimerUtil(delay:Number, repeatCount:int=0) 
		{
			super(delay, repeatCount)
		}
		
		/**
		 * Calls the specified callback function after the given delay time (milliseconds has elapsed).
		 * The callback function is automatically deregistered from Timers EventDispatcher after it is called.
		 *  
		 * @param delay The time to wait before calling the callback function
		 * @param callback the function to callback after the specified delay has elapsed
		 * @return The Timer instance created
		 */		
		public static function once(delay:Number, callback:Function):TimerUtil 
		{
			var timer:TimerUtil = new TimerUtil(delay, 1)
			timer.addEventListener
			(
				TimerEvent.TIMER, 
				function(event:TimerEvent):void 
				{
					timer.removeEventListener(event.type, arguments.callee)
					delete activeTimers[timer]
					callback(event)
				}
			)
			
			activeTimers[timer] = timer
			timer.start()
			
			return timer
		} 
		
		
		/**
		 * Calls the specified callback function repeatedly after the given delay time (milliseconds has elapsed).
		 *
		 * @param delay The time to wait before calling the callback function
		 * @param repeatCount The amount of times to call the callback function. An amount of zero will call the callback function infinitely 
		 * @param callback callback the function to callback after the specified delay has elapsed
		 * @return The Timer instance created
		 */		
		public static function repeat(delay:Number, callback:Function, repeatCount:int=0):TimerUtil 
		{
			var timer:TimerUtil = new TimerUtil(delay, repeatCount)
			timer.addEventListener(TimerEvent.TIMER, callback)
			timer.start()
			
			return timer
		}
		
		
		/**
		 * Call a set of functions at given relative times. Each even numbered argument (from a zero index, with zero being even)
		 * is a time in milliseconds. This is the time delayed before calling the function that is passed in after the time. The times are also 
		 * accumulative, so if you pass in:
		 * 
		 * <code>
		 * IJsTimer.mapTimeToFunction(
		 * 
		 * 	1000, first,
		 * 	2000, second
		 * 	3000, third
		 * 
		 * )
		 * </code>
		 * 
		 * Then first() is called after 1 second, second is called after 3 seconds and thrid is called after 6 seconds etc.
		 * 
		 * @param timeFunctionMap 
		 */	
		public static function mapTimeToFunction(...timeFunctionMap:Array):void 
		{
			var delay:Number
			var delayTotal:Number = 0
			var callback:Function
			var i:int=0
			
			while (i<timeFunctionMap.length)
			{
				if (timeFunctionMap[ i ] is Number) 	delay = timeFunctionMap[ i ]
				else									throw new ArgumentError('all even indices of the map should be valid Numbers')
				
				++i
				
				if (i<timeFunctionMap.length)
				{
					if (timeFunctionMap[ i ] is Function) 	callback = timeFunctionMap[ i ]
					else									throw new ArgumentError('all odd indices of the map should be valid Functions')
					
					++i
					delayTotal += delay
					once(delayTotal, callback)
				}
			}
		}
		
		
		public static function convertMillisecondsToSeconds(milliseconds:Number):Number 
		{
			return milliseconds / MILLISECONDS_PER_SECOND 
		}
		
		
		public static function convertMillisecondsToMinutes(milliseconds:Number):Number 
		{
			return milliseconds / MILLISECONDS_PER_MINUTE
		}
		
		
		public static function convertMillisecondsToHours(milliseconds:Number):Number 
		{
			return milliseconds / MILLISECONDS_PER_HOUR
		}
		
		
		/**
		 * 
		 * @param milliseconds
		 * @return 
		 * 
		 */	
		public static function convertMillisecondsToDateString(milliseconds:Number):String 
		{
			var date:Date = new Date(-MILLISECONDS_PER_HOUR + milliseconds)
			return date.toDateString().slice(0, 9)
		}
		
		
		/**
		 * Converts a value in milliseconds to a timeString
		 * @param milliseconds the millisecond value to convert to a time String
		 * @return the time String of the millisecond value given
		 */	
		public static function convertMillisecondsToTimeString(milliseconds:Number, format:String='hh:mm:ss'):String 
		{
			format = format.toLowerCase()
			var date:Date = new Date(-TimerUtil.MILLISECONDS_PER_HOUR + milliseconds)
			var dateString:String = date.toTimeString()
			
			var hours:uint
			var minutes:uint
			var seconds:uint
			
			switch(format) 
			{
				case 'hh:mm:ss': 	dateString = dateString.slice(0, 8) 
				break
				
				case 'mm:ss': 		
					hours		= parseInt(dateString.slice(0, 2))
					minutes		= parseInt(dateString.slice(3, 5))
					seconds		= parseInt(dateString.slice(6, 8))
					
					minutes += hours * MINUTES_PER_HOUR
					dateString = StringUtil.prependZeros(minutes+'', 2) + ':' + StringUtil.prependZeros(seconds+'', 2)
				break
				
				case 'ss': 			
					hours		= parseInt(dateString.slice(0, 2))
					minutes		= parseInt(dateString.slice(3, 5))
					seconds		= parseInt(dateString.slice(6, 8))
					
					minutes += hours * SECONDS_PER_HOUR
					seconds += minutes * SECONDS_PER_MINUTE
					dateString = StringUtil.prependZeros(seconds+'', 2) 
				break
				
				case 's': 			
					hours		= parseInt(dateString.slice(0, 2))
					minutes		= parseInt(dateString.slice(3, 5))
					seconds		= parseInt(dateString.slice(6, 8))
					
					minutes += hours * SECONDS_PER_HOUR
					seconds += minutes * SECONDS_PER_MINUTE
					dateString = seconds.toString()
				break
				
				default:			date.toTimeString().slice(0, 8) break
			}
			
			return dateString
		}
		
		
		/**
		 * Give a time like 15:45:00 and get miliseconds (UTC) back
		 * @param time A valid time String accepted by the Date class
		 * @return the millisecond value of the given timeString in UTC time
		 */ 
		public static function getMiliSecondsFromTimeString(time:String) : Number
		{
			var dateToday:Date 			= new Date()	
			var dateToCalculate:Date	= new Date(dateToday.toDateString() + ' ' + time)
			
			return dateToCalculate.time
		}
	}
}
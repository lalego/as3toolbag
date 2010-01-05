package eu.powdermonkey.utils
{
	public class StringUtil
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
		
		public static function intersperseSpace(...tokens):String
		{
			tokens.unshift(' ')
			return intersperse.apply(null, tokens)
		}
		
		public static function intersperse(seperator:String=null, ...tokens):String
		{
			var packed:String = ''
			var i:int=0
			
			if (seperator != null)
			{
				for (; i<tokens.length; ++i)
				{
					packed += tokens[i] + seperator
				}
				
				packed = packed.slice(0, -1)
			}
			else
			{
				for (; i<tokens.length; ++i)
				{
					packed += tokens[i]
				}
			}
			
			return packed
		}
		
		public static function insertNewlines(...tokens):String
		{
			var result:String = ''
			
			for (var i:int=0; i<tokens.length; ++i)
			{
				result += tokens[i] + "\n"
			}
			
			result.slice(0, -1)
			
			return result
		}
		
		public static function stripNewlines(text:String):String
		{
			return text.replace(/\n/g, '')
		}
		
		/**
		 * Replaces runs of the given character are replaced by a single instance of the character 
		 * @param value
		 * @param pattern
		 * @return 
		 * 
		 */		
		public static function squeezeWhitespace(text:String):String
		{
			return text.replace(/\s+/g, ' ')
		}
		
		public static function stripWhitespace(text:String):String
		{
			return text.replace(/\s+/g, '')
		}
		
		public static function strip(text:String):String
		{
			return rightStrip(leftStrip(text))
		}
		
		public static function rightStrip(text:String):String
		{
			return text.replace(/\s+$/gs, '')
		}
		
		public static function leftStrip(text:String):String
		{
			return text.replace(/^\s+/gs, '')
		}
		
		/**
		 * @param str the string to test for emptiness.
		 * Emptiness is defined as being of length 0, or only containing whitespace characters
		 *  
		 * @return True if the string is classified as empty
		 */	
		public static function isEmpty(str:String):Boolean 
		{
			return str.match(/^\s*$/) != null
		}
		
		
		/**
		 * @param str The string to test for being a valid number.
		 * A valid number can have a decimal point 
		 * 
		 * @return True if the string is a valid number
		 */	
		public static function isNumber(str:String):Boolean 
		{
			return str.match(/^\d+(\.\d+)?$/) != null
		}
		
		/**
		 * @param str 
		 * @return 
		 */	
		public static function isInt(str:String):Boolean 
		{
			return str.match(/^\d*$/) != null
		}
		
		/**
		 * @param str 
		 * @return 
		 */	
		public static function isBoolean(str:String):Boolean 
		{
			return str.match(/^(true|false)$/) != null
		}
		
		public static function formatNumber(number:Number):String
		{
			var numString:String = number.toString()
			var result:String = ''
			
			while (numString.length > 3)
			{
				var chunk:String = numString.substr(-3)
				numString = numString.substr(0, numString.length - 3)
				result = ',' + chunk + result
			}
			
			if (numString.length > 0)
			{
				result = numString + result
			}
			
			return result
		}
		
		/**
		 * @param numberString the existing number string
		 * @param totalDigits
		 * @return 
		 */	
		public static function prependZeros(numberString:String, totalDigits:uint):String 
		{
			var numberPadded:String = numberString
			var zerosToAdd:int = totalDigits - numberString.length
			
			if (isNumber(numberString) && zerosToAdd > 0)
			{
				numberPadded = prependString(numberPadded, '0', zerosToAdd)
			}
			
			return numberPadded 
		}
		
		/**
		 * @param text the test that we should prepend the tokenToPrepend onto 
		 * @param tokenToPrepend the token to prepend to the text string
		 * @param amountToAdd the amount of times to prepend the token
		 * @return the text string with the token string prepended 'amountToAdd'ø amount of times
		 */	
		public static function prependString(text:String, tokenToPrepend:String, amountToAdd:int=1):String 
		{
			var textPadded:String = text
			
			if (amountToAdd > 0)
			{
				while (--amountToAdd >= 0)
				{
					textPadded = tokenToPrepend + textPadded
				}
			}		
			
			return textPadded
		}
		
		/**
		 * @param text
		 * @param token
		 * @return 
		 */	
		public static function trimFromFront(text:String, token:String):String 
		{
			return text.replace(new RegExp('^' + token + '*'), '')
		}
		
		public static function isValidURL(url:String):Boolean 
		{
			var regex:RegExp = new RegExp
			(
				'^([a-zA-Z0-9_\-\.]+)@((\[[0-9]{1,3}' +
	            '\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-zA-Z0-9\-]+\\' +
	            '.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$'
			)
			
			return url.match(regex) != null
		}
		
		public static function tokenSandwich(token:String, ...fillings):String 
		{
			var filling:String
			var sandwich:String = '' 
			
			for (var i:int=0; i<fillings.length; ++i)
			{
				filling = fillings[ i ]	
				if (i<fillings.length-1) 	sandwich += addTrailingToken(token, filling)
				else						sandwich += filling
			}
			
			return sandwich 
		} 
		
		public static function repeat(token:String, amount:int):String
		{
			var result:String = ''
			
			while(--amount >= 0)
			{
				result += token
			}
			
			return result 
		} 
		
		/**
		 * @param token
		 * @param base
		 * @return 
		 */	
		public static function addTrailingToken(token:String, base:String):String 
		{
			var baseWithToken:String = base
			
			if (hasTrailingToken(token, base) == false)
			{
				baseWithToken = base + token
			}
			
			return baseWithToken
		}
		
		/**
		 * @param token
		 * @param base
		 * @return 
		 */	
		public static function addLeadingToken(token:String, base:String):String 
		{
			var baseWithToken:String = base
			
			if (hasLeadingToken(token, base) == false)
			{
				baseWithToken = token + base
			}
			
			return baseWithToken
		}
		
		public static function wrapInForwardSlashes(token:String):String
		{
			return addLeadingForwardSlash(addTrailingForwardSlash(token))
		}
		
		public static function addTrailingForwardSlash(url:String):String 
		{
			if (hasTrailingForwardSlash(url))
			{
				return url
			}
			else
			{
				return addTrailingToken('/', url)
			}
		}
		
		public static function addLeadingForwardSlash(url:String):String 
		{
			return addLeadingToken('/', url)
		}
		
		public static function trimTrailingForwardSlash(url:String):String 
		{
			var urlTrimmed:String = url
			
			if (hasTrailingForwardSlash(url))
			{
				urlTrimmed = url.replace(/\/$/, '')
			}
			
			return url
		}
		
		public static function trimLeadingForwardSlash(url:String):String 
		{
			var urlTrimmed:String = url
			
			if (hasLeadingForwardSlash(url))
			{
				urlTrimmed = url.replace(/^\//, '')
			}
			
			return url
		}
		
		/**
		 * @param url the url to check for a trailing forward slash
		 * @return true if the given url has a trailing forward slash 
		 */	
		public static function hasTrailingForwardSlash(url:String):Boolean 
		{
			return hasTrailingToken('/', url)				
		}
		
		public static function hasLeadingForwardSlash(url:String):Boolean 
		{
			return hasLeadingToken('/', url)				
		}
		
		public static function hasTrailingToken(token:String, base:String):Boolean 
		{
			var regex:RegExp = new RegExp(token + '$')
			return regex.exec(base) != null
		}
		
		public static function hasLeadingToken(token:String, base:String):Boolean 
		{
			var regex:RegExp = new RegExp('^' + token)
			return regex.exec(base) != null
		}
		
		public static function capitalize(word:String):String
		{
			var wordCapitalised:String = word.charAt(0).toUpperCase() + word.substring(1)
			return wordCapitalised
		}
		
		public static function buildCamelCase(words:Array /* of String */):String
		{
			var wordCamelcase:String = ''
			
			if (words.hasNext)
			{
				var firstWord:String = words.next()
				firstWord = firstWord.toLowerCase()
				wordCamelcase = firstWord
				
				var eachWord:String
				
				while (words.hasNext)
				{
					eachWord = words.next()
					wordCamelcase += StringUtil.capitalize(eachWord)
				}
			}
			
			return wordCamelcase
		}
		
		/**
		 * Converts a value in milliseconds to a timeString
		 * @param milliseconds the millisecond value to convert to a time String
		 * @return the time String of the millisecond value given
		 */	
		public static function millisecondsToTimeString(milliseconds:Number, format:String='hh:mm:ss'):String 
		{
			format = format.toLowerCase()
			var date:Date = new Date(-StringUtil.MILLISECONDS_PER_HOUR + milliseconds)
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
					dateString = StringUtil.prependZeros(String(minutes), 2) + ':' + StringUtil.prependZeros(String(seconds), 2)
				break
				
				case 'ss': 			
					hours		= parseInt(dateString.slice(0, 2))
					minutes		= parseInt(dateString.slice(3, 5))
					seconds		= parseInt(dateString.slice(6, 8))
					
					minutes += hours * SECONDS_PER_HOUR
					seconds += minutes * SECONDS_PER_MINUTE
					dateString = StringUtil.prependZeros(String(seconds), 2) 
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
	}
}
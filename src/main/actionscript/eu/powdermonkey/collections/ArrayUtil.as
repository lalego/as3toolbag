package eu.powdermonkey.collections
{
	import flash.utils.Dictionary;
	
	public class ArrayUtil
	{
		/**
		 * @param arrayToPickFrom
		 * @return 
		 */	
		public static function pickRandomElement(arrayToPickFrom:Array):* 
		{
			var index:uint = Math.round(Math.random() * (arrayToPickFrom.length-1))
			return arrayToPickFrom[ index ]
		}
		
		
		/**
		 * @param endID the ID that will be in the last element of the array
		 * @param startID the ID that will be in the first element of the array
		 * @return An array of ids in sequential order from the start ID to end ID
		 */	
		public static function range(endID:int, startID:int=0):Array /* of int */ 
		{
			var sequentialArray:Array /* of int */ = []
			var totalElements:uint = endID - startID
			var i:int
			
			if (totalElements > 0)
			{
				for (i=startID; i<=totalElements; i++)
				{
					sequentialArray[i] = startID + i
				}
			}
			else
			{
				totalElements = -totalElements
				
				for (i=startID; i<=totalElements; i++)
				{
					sequentialArray[i] = startID - i
				}
			}		
			
			return sequentialArray
		}
		
		
		/**
		 * Creates a copy of the specified array.
		 *
		 * Note that the array returned is a new array but the items within the
		 * array are not copies of the items in the original array (but rather 
		 * references to the same items)
		 * 
		 * @param arrayToCopy
		 * @return a new Array with duplicate references to the items contained within the old array
		 */	
		public static function copyArray(arrayToCopy:Array):Array /* of * */ 
		{
			if (arrayToCopy == null) 	throw new ArgumentError('You need to provide an Array to copy')
			return arrayToCopy.slice()
		}
		
		
		/**
		 * Randomly shuffles the given array
		 * @param arrayToShuffle The array to shuffle
		 * @return The shuffled array
		 * @throws ArgumentError if the Array given is null
		 */	
		public static function shuffle(arrayToShuffle:Array):Array /* of * */
		{
			var arrayShuffled:Array /* of * */ = []
			
			if (arrayToShuffle.length > 1)
			{
				var arrayUnshuffled:Array = copyArray(arrayToShuffle)
				var element:Object
				var index:uint
				
				while (arrayShuffled.length < arrayToShuffle.length)
				{
					index = Math.round(Math.random() * (arrayUnshuffled.length-1)) 
					element = arrayUnshuffled[ index ]
					arrayUnshuffled.splice(index, 1)
					arrayShuffled.push(element)
				}
				
			}
			else if (arrayToShuffle.length == 1)
			{
				arrayShuffled.push(arrayToShuffle[0])
			}
			
			return arrayShuffled 
		}
		
		
		/**
		 * Finds the index of the given object in the given array
		 * 
		 * @param array The Array the object might be in 
		 * @param object The object to search for 
		 * @return the index of the object in the array, or -1 if the object isn't found
		 */	
		public static function getIndexOf(array:Array, object:Object):int 
		{
			var index:int = -1
			var child:Object 
			
			for (var i:int=0; i<array.length; ++i)
			{
				child = array[ i ]
				
				if (child == object)
				{
					index = i
					break
				}
			}
			
			return index
		}
		
		
		/**
		*	Remove all instances of the specified value from the array,
		* 
		* 	@param arr The array from which the value will be removed
		*
		*	@param value The object that will be removed from the array.
		*
		* 	@langversion ActionScript 3.0
		*	@playerversion Flash 9.0
		*	@tiptext
		*/		
		public static function removeValueFromArray(arr:Array, value:Object):void
		{
			var len:uint = arr.length;
			
			for (var i:Number = len-1; i > -1; i--)
			{
				if(arr[i] === value)
				{
					arr.splice(i, 1);
				}
			}					
		}
		
		public static function removeClassesFromArray(arr:Array, clazz:Class):void
		{
			var len:uint = arr.length;
			
			for (var i:Number = len-1; i > -1; i--)
			{
				if(arr[i] is clazz)
				{
					arr.splice(i, 1);
				}
			}					
		}
		
		
		public static function isContained(array:Array, element:*):Boolean
		{
			var iscontained:Boolean = false
			
			for each (var eachElement:* in array)
			{
				if (eachElement == element)
				{
					iscontained = true
					break
				}	
			}
			
			return iscontained
		}
		
		public static function copyToDictionary(array:Array, mappingCallback:Function):Dictionary
		{
			var dictionary:Dictionary = new Dictionary()
			
			for each (var child:* in array)
			{
				var mapping:Object = mappingCallback(child)
				dictionary[mapping.key] = mapping.value
			}
			
			return dictionary
		}
		
		public static function copyToDictionaryKeyValue(array:Array):Dictionary
		{
			var dictionary:Dictionary = new Dictionary()
			
			for each (var child:* in array)
			{
				dictionary[child] = child
			}
			
			return dictionary
		}
	}
}
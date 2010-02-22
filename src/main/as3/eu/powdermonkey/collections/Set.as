package eu.powdermonkey.collections
{
	import flash.utils.Dictionary;
	
	public class Set
	{
		private static const EmptySet:Set = new Set(new Dictionary())
		
		public static function empty():Set
		{
			return EmptySet
		}
		
		public static function fromArray(elements:Array):Set
		{
			var elementsDict:Dictionary = new Dictionary()
			
			for each (var element:* in elements)
			{
				elementsDict[element] = element
			}
			
			return new Set(elementsDict)
		}
		
		public static function fromEach(...elements):Set
		{
			return fromArray(elements)
		}
				
		private var _elements:Dictionary = new Dictionary()
		
		private var _elementAmount:int = 0
		
		public function Set(elements:Dictionary)
		{
			_elements = elements
			
			for (var element:* in elements)
			{
				++_elementAmount
			}
		}
		
		public function union(other:Set):Set
		{
			var setBuilder:SetBuilder = new SetBuilder(_elements)
			
			for (var element:* in other._elements)
			{
				setBuilder.add(element)
			}
			
			return new Set(setBuilder.elements)
		}
		
		public function minus(other:Set):Set
		{
			var setBuilder:SetBuilder = new SetBuilder()
			
			for (var element:* in other._elements)
			{
				if (!contained(element))
				{
					setBuilder.add(element)
				}
			}
			
			return new Set(setBuilder.elements)
		}
		
		public function intersection(other:Set):Set
		{
			var setBuilder:SetBuilder = new SetBuilder()
			
			for (var element:* in other._elements)
			{
				if (contained(element))
				{
					setBuilder.add(element)
				}
			}
			
			return new Set(setBuilder.elements)
		}
		
		public function contained(element:*):Boolean
		{
			return element in _elements
		}
		
		public function get elementAmount():int
		{
			return _elementAmount
		}
		
		public function get length():int
		{
			return _elementAmount
		}
		
		public function toArray():Array
		{
			var result:Array = []
			
			for (var element:* in _elements)
			{
				result.push(element)
			}
			
			return result
		}
		
		public function toString():String
		{
			return '[Set elementsAmount:' + _elementAmount + ']'
		}
	}
}

import flash.utils.Dictionary;	

class SetBuilder
{
	private var _elements:Dictionary = new Dictionary()
	
	public function SetBuilder(elements:Dictionary=null)
	{
		if (elements != null)
		{
			for (var element:* in elements)
			{
				add(element)
			}
		}
	}
	
	public function add(element:*):void
	{
		_elements[element] = element
	}
	
	public function get elements():Dictionary
	{
		return _elements
	}
}
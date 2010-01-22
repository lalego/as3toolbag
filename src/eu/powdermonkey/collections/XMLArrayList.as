package eu.powdermonkey.collections
{
	import eu.powdermonkey.collections.methods.*;
	import eu.powdermonkey.maths.methods.*;
	
	import flash.utils.Dictionary;	
	
	public class XMLArrayList extends ArrayList implements IList
	{
		private var xmlList:XMLList
		
		public function XMLArrayList(xmlList:XMLList)
		{
			super(xmlListToArray(xmlList))
			this.xmlList = xmlList
		}
		
		override public function cloneReset():IIterator
		{
			return new XMLArrayList(xmlList)
		}
		
		override public function toXMLList():XMLList
		{
			return xmlList.copy()
		}
		
		override public function toString():String
		{
			return xmlList.toString()
		}
	}
}
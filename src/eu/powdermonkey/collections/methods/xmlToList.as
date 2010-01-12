package eu.powdermonkey.collections.methods
{
	import eu.powdermonkey.collections.IList;
	import eu.powdermonkey.collections.XMLArrayList;
	
	public function xmlToList(xmlList:XMLList):IList
	{
		return new XMLArrayList(xmlList)
	}
}

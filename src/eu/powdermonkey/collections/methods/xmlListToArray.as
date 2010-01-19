package eu.powdermonkey.collections.methods
{
	public function xmlListToArray(xmlList:XMLList):Array
	{
		var array:Array = []
		
		for each (var child:XML in xmlList)
		{
			array.push(child)
		}
		
		return array
	}
}
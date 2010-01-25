package eu.powdermonkey.collections.methods
{
	public function eachXML(callback:Function):Function
	{
		return function (xml:XML):*
		{
			return callback(xml)
		}
	}
}
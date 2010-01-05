package eu.powdermonkey.collections.methods
{
	public function filterto(callback:Function):Function
	{
		return function (object:*, index:int, array:Array):Boolean
		{
			return callback(object)
		}
	}
}
package eu.powdermonkey.collections.methods
{
	public function forallIndexed(callback:Function):Function
	{
		return function (object:*, index:int, array:Array):* {
			return callback(object, index, array.length)
		}
	}
}
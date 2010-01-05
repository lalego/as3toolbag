package eu.powdermonkey.collections.methods
{
	public function maptoIndexed(callback:Function):Function
	{
		return function (object:*, index:int, array:Array):* {
			return callback(object, index, array.length)
		}
	}
}

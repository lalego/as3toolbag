package eu.powdermonkey.collections.methods
{
	public function forall(callback:Function):Function
	{
		return function (object:*, index:int, array:Array):* {
			return callback(object)
		}
	}
}
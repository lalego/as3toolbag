package eu.powdermonkey.collections.methods.reductions
{
	public function sum():Function
	{
		return function (sum:Number, value:Number):Number
		{
			return sum + value
		}
	}
}
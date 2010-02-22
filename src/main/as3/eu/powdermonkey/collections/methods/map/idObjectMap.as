package eu.powdermonkey.collections.methods.map
{
	public function idObjectMap():Function
	{
		return function (object:*):Object
		{
			return {key:object['id'], value:object}
		}
	}
}
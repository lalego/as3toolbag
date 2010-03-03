package eu.powdermonkey.collections.methods.map
{
	public function keyValue(keyField:String, valueField:String):Function
	{
		var elementAliasPattern:RegExp = /object|element/ 
		var keyFieldisObject:Boolean = keyField.search(elementAliasPattern) == 0
		var valueFieldisObject:Boolean = keyField.search(elementAliasPattern) == 0
		
		if (keyFieldisObject)
		{
			if (valueFieldisObject)
			{
				return function (object:*):Object
				{
					return {key:object, value:object}
				}
			}
			else
			{
				return function (object:*):Object
				{
					return {key:object, value:object[valueField]}
				}
			}
		}
		else if (valueFieldisObject)
		{
			return function (object:*):Object
			{
				return {key:object[valueField], value:object}
			}
		}
		else
		{
			return function (object:*):Object
			{
				return {key:object[keyField], value:object[keyField]}
			}
		}
	}
}
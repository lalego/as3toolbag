package eu.powdermonkey.utils.strings
{
	import eu.powdermonkey.utils.StringUtil;
	
	public function intersperseSpaces(... tokens):String
	{
		return StringUtil.intersperseSpaces.apply(null, tokens)
	}
}
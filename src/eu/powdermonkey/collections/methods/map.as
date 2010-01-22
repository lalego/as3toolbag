package eu.powdermonkey.collections.methods
{
	import eu.powdermonkey.collections.IMap;
	import eu.powdermonkey.collections.Map;
	
	public function map(pairs:Array):IMap
	{
		return Map.fromArray(pairs)
	}
}
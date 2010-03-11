package eu.powdermonkey.maths
{
	import asunit.asserts.*;
	
	public class RangeTest
	{
		[Test]
		public function shoundIterate():void
		{
			var range:Range = new Range(10, 20)
			for each (var value:int in range)
			{
				trace('value:' + value)
			}
		}
	}
}
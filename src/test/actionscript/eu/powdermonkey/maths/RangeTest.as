package eu.powdermonkey.maths
{
	import asunit.asserts.*;
	
	import eu.powdermonkey.maths.range.range;
	
	public class RangeTest
	{
		[Test]
		public function zeroRangeShouldNotIterate():void
		{
			var r:Range = range(0, 0)
			for each (var value:int in r)
			{
				fail()
			}
		}
		
		[Test]
		public function oneToRange():void
		{
			var r:Range = range(1, 10)
			
			for each (var value:int in r)
			{
				trace('value:' + value)
			}
			
			assertEquals(9, r.length)
			assertEquals(1, r.min)
			assertEquals(10, r.max)
		}
		
		[Test]
		public function shoundIterate():void
		{
			var r:Range = new Range(10, 20)
			for each (var value:int in r)
			{
				trace('value:' + value)
			}
		}
	}
}
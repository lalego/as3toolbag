package eu.powdermonkey
{
	import asunit.framework.TestSuite;
	
	import eu.powdermonkey.collections.ArrayListTest;
	import eu.powdermonkey.view.DepthSorterTest;

	[Suite]
	public class AllTests extends TestSuite
	{
		public var _ArrayListTest:ArrayListTest
		public var _DepthSorterTest:DepthSorterTest
	}
}
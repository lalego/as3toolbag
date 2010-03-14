package eu.powdermonkey
{
	import eu.powdermonkey.collections.ArrayListTest;
	import eu.powdermonkey.maths.RangeTest;
	import eu.powdermonkey.signals.SignalSyncTest;
	import eu.powdermonkey.view.DepthSorterTest;

	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class AllTests
	{
		public var arrayListTest:ArrayListTest
		public var depthSorterTest:DepthSorterTest
		public var rangeTest:RangeTest
		public var signalSyncTest:SignalSyncTest
	}
}
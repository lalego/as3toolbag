package eu.powdermonkey
{
	import eu.powdermonkey.maths.RangeTest;
	import eu.powdermonkey.signals.SignalSyncTest;
	import eu.powdermonkey.view.DepthSorterTest;
	
	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class AllTests
	{
		public var test1:eu.powdermonkey.maths.RangeTest;
		public var test2:eu.powdermonkey.signals.SignalSyncTest;
		public var test3:eu.powdermonkey.view.DepthSorterTest;
	}
}
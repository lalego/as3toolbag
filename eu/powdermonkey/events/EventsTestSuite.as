package eu.powdermonkey.events
{
	import nl.gamewise.as3unit.core.TestSuite;

	public class EventsTestSuite extends TestSuite
	{
		public function EventsTestSuite()
		{
			addTestCase(new EventDispatcherFlowTest())
		}
	}
}
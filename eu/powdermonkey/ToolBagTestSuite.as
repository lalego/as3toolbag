package eu.powdermonkey
{
	import eu.powdermonkey.events.EventsTestSuite;
	
	import nl.gamewise.as3unit.core.TestSuite;

	public class ToolBagTestSuite extends TestSuite
	{
		public function ToolBagTestSuite()
		{
			addTestSuite(new EventsTestSuite())
		}
	}
}
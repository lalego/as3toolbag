package
{
	import asunit4.ui.MinimalRunnerUI;
	
	import eu.powdermonkey.AllTests;

	[SWF(width="1000", height="800", backgroundColor="#333333")]
	public class AllTestsRunner extends MinimalRunnerUI
	{
		public function AllTestsRunner()
		{
			run(AllTests)
		}
	}
}
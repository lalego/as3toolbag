package eu.powdermonkey
{
	import asunit4.ui.MinimalRunnerUI;

	[SWF(width="1000", height="800", backgroundColor="#333333")]
	public class AllTestsRunner extends MinimalRunnerUI
	{
		public function AllTestsRunner()
		{
			run(eu.powdermonkey.AllTests)
		}
	}
}
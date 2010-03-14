package
{
	import eu.powdermonkey.AllTests;
	
	import org.flexunit.flexui.TestRunnerBase;
	import org.flexunit.listeners.UIListener;
	import org.flexunit.runner.FlexUnitCore;

	[SWF(width="1000", height="800", backgroundColor="#333333")]
	public class AllTestsRunner extends org.flexunit.
	{
		private var core:FlexUnitCore
		
		public function runMe():void
		{
			core = new FlexUnitCore()
			core.addListener(new UIListener(this))
			core.run(eu.powdermonkey.AllTests)
		}
	}
}
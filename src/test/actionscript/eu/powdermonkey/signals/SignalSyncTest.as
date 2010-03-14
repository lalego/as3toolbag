package eu.powdermonkey.signals
{
	import org.osflash.signals.Signal;
	
	public class SignalSyncTest
	{
		[Test]
		public function shouldHandleSignalWithNoArguments():void
		{
			var signal:Signal = new Signal()
			var sync:SignalSync = new SignalSync().add(signal)
			sync.synced.add(
				function ():void {
					trace('dispatched')
				}
			)
			signal.dispatch()
		}
	}
}
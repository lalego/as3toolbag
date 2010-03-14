package eu.powdermonkey.signals
{
	import flash.utils.Dictionary;
	
	import org.osflash.signals.Signal;
	
	public class SignalSync
	{
		public const synced:Signal = new Signal()
		
		private var syncDispatched:Boolean 
		
		private var pending:Dictionary = new Dictionary()
		
		public function add(signal:Signal):SignalSync
		{
			pending[signal] = false
			signal.addOnce(
				function (...args):void {
					pending[signal] = true
					if(haveAllSignalsDispatched())
					{
						synced.dispatch()
						syncDispatched = true
					}
				}
			)
			return this
		}
		
		public function waitingOn():Array
		{
			return filter(
				function (signal:Signal, dispathed:Boolean):Boolean {
					return !dispathed
				}
			)
		}
		
		public function dispathed():Array
		{
			return filter(
				function (signal:Signal, dispathed:Boolean):Boolean {
					return dispathed
				}
			)
		}
		
		private function foreach(callback:Function):void
		{
			for (var signal:* in pending)
			{
				callback(signal, waitingOn[signal])
			}
		}
		
		private function filter(callback:Function):Array
		{
			var filtered:Array = []
			
			foreach(
				function (signal:Signal, dispathed:Boolean):void {
					if(callback(signal, dispathed))
					{
						filtered.push(signal)
					}
				}	
			)
			
			return filtered
		}
		
		private function haveAllSignalsDispatched():Boolean
		{
			var allSynced:Boolean = false
				
			for (var signal:* in pending)
			{
				allSynced &&= waitingOn[signal]
			}
			
			return allSynced
		}
		
		public function hasSynced():Boolean
		{
			return syncDispatched
		}
	}
}

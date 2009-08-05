package eu.powdermonkey.view
{
	import eu.powdermonkey.events.EventDispatcherFlow;
	import eu.powdermonkey.events.EventForwarder;
	import eu.powdermonkey.events.FlowStateActiveEvent;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;

	public class DisplayObjectFlow extends Sprite 
	{
		private var _eventDispatcherFlow:EventDispatcherFlow
		
		public function DisplayObjectFlow(displayObjectList:Array)
		{
			_eventDispatcherFlow = new EventDispatcherFlow(displayObjectList)
			EventForwarder.forwardEvent(_eventDispatcherFlow, this, Event.COMPLETE)
			_eventDispatcherFlow.addEventListener(FlowStateActiveEvent.ACTIVE, onStateActivated)
			gotoStart()
		}
		
		public function gotoStart():void
		{
			_eventDispatcherFlow.start()
		}
		
		private function onStateActivated(event:FlowStateActiveEvent):void
		{
			var activated:DisplayObject = DisplayObject(event.activated)
			
			if (event.hasDeactivated)
			{
				var deactivated:DisplayObject = DisplayObject(event.deactivated)
				removeChild(deactivated)
			}
			
			addChild(activated)
		}
	}
}
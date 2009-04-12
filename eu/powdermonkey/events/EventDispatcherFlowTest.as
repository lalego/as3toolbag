package eu.powdermonkey.events
{
	import flash.events.Event;
	
	import nl.gamewise.as3unit.core.TestUnit;

	public class EventDispatcherFlowTest extends TestUnit
	{
		public function testOneElementSequence():void
		{
			var state:DummyState = new DummyState(Event.COMPLETE)
			var eventFlow:EventDispatcherFlow = new EventDispatcherFlow([state])
			eventFlow.start()
			
			assertIsTrue('Afrer start() is called, "eventFlow" should be started', eventFlow.isStarted)
			assertIsTrue("Poo poo", false)
		}
		
		public function testTwoElementSequence():void
		{
			var stateA:DummyState = new DummyState(Event.COMPLETE)
			var stateB:DummyState = new DummyState(Event.COMPLETE)
			var stateC:DummyState = new DummyState(Event.COMPLETE)
			var eventFlow:EventDispatcherFlow = new EventDispatcherFlow([stateA, stateB, stateC])
		}
		
		public function testThreeElementSequence():void
		{
			
		}
	}
}

import flash.events.EventDispatcher;
import flash.events.Event;
	
class DummyState extends EventDispatcher
{
	private var _triggerEventType:String
	
	public function DummyState(triggerEventType:String)
	{
		_triggerEventType = triggerEventType
	}
	
	public function dispatchTrigger():void
	{
		dispatchEvent(new Event(_triggerEventType))
	}
}
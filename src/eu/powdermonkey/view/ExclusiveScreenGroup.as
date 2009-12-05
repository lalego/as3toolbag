package eu.powdermonkey.view
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.utils.Dictionary;

	public class ExclusiveScreenGroup extends Sprite
	{
		private var _screens:Dictionary = new Dictionary() 
		
		private var _screenShowing:DisplayObject
		
		public function ExclusiveScreenGroup(screens:Array)
		{
			prepareScreens(screens)
		}
		
		protected function showScreen(clazz:Class):void
		{
			if (clazz in _screens)
			{
				var screen:DisplayObject = _screens[clazz]
				
				if (_screenShowing != null)
				{
					_screenShowing.visible = false
				}
				
				_screenShowing = screen
				screen.visible = true
			}
		}
		
		private function prepareScreens(screens:Array):void
		{
			for each (var screen:DisplayObject in screens)
			{
				var clazz:Class = Object(screen).constructor
				
				if (clazz in _screens)
				{
					trace('screen ignored, its type(' + clazz +') is already in this exclusive group')
				}
				else
				{
					_screens[clazz] = screen
					screen.visible = false
					addChild(screen)
				}
			}
		}
		
		protected function showOnEvent(dispatcher:IEventDispatcher, eventType:String, screenClass:Class):void
		{
			dispatcher.addEventListener
			(
				eventType,
				function (event:Event):void
				{
					showScreen(screenClass)
				},
				false,
				0,
				true
			)
		}
	}
}
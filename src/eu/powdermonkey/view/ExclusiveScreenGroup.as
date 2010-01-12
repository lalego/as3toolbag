package eu.powdermonkey.view
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;

	public class ExclusiveScreenGroup extends Sprite
	{
		public static function build(...screens):ExclusiveScreenGroup
		{
			var unrolledScreens:Array = []
			
			for each (var screen:DisplayObject in screens)
			{
				unrolledScreens.push(screen)
			}
			
			return new ExclusiveScreenGroup(unrolledScreens)
		}
		
		public static function buildOpen(...screens):ExclusiveScreenGroup
		{
			var unrolledScreens:Array = []
			
			for each (var screen:DisplayObject in screens)
			{
				unrolledScreens.push(screen)
			}
			
			return new ExclusiveScreenGroup(unrolledScreens, true)
		}
		
		private var _screenShowing:DisplayObject
		
		private var _openToNewMembers:Boolean
		
		public function ExclusiveScreenGroup(screens:Array, openToNewMembers:Boolean=false)
		{
			_openToNewMembers = openToNewMembers 
			
			for each (var screen:DisplayObject in screens)
			{
				addScreen(screen)
			}
		}
		
		private function addScreen(screen:DisplayObject):void
		{
			super.addChild(screen)
			screen.visible = false
		}
		
		public function showScreen(screen:DisplayObject):void
		{
			if (_openToNewMembers)
			{
				if (contains(screen) == false)
				{
					addScreen(screen)
				}
			}
			else
			{
				if (contains(screen) == false)
				{
					throw new Error('screen ('+screen+') is not a member of this group, add it at creation')
				}
			}
			
			if (_screenShowing != null)
			{
				hideScreen(_screenShowing)
			}
			
			showScreenIntern(screen)
			_screenShowing = screen
		}
		
		private function showScreenIntern(screen:DisplayObject):void
		{
			if (screen is IShowable)
			{
				IShowable(screen).show()
			}
			else
			{
				screen.visible = true
			}
		}
		
		protected function hideScreen(screen:DisplayObject):void
		{
			if (screen is IShowable)
			{
				IShowable(screen).hide()
			}
			else
			{
				screen.visible = false
			}
		}
		
		public function hideCurrent():void
		{
			if (_screenShowing != null)
			{
				hideScreen(_screenShowing)
			}	
		}
	}
}
package eu.powdermonkey.view
{
	import flash.display.DisplayObject;
	import flash.utils.Dictionary;
	
	public class ExclusiveScreenSet extends ExclusiveScreenGroup
	{
		private var _screenSet:Dictionary = new Dictionary()
		
		public function ExclusiveScreenSet(screens:Array, openToNewMembers:Boolean=true)
		{
			super(screens, openToNewMembers);
		}
		
		public function showNamedScreen(id:String, screen:DisplayObject):void
		{
			if (id in _screenSet)
			{
				var oldScreen:DisplayObject = _screenSet[id]
				removeChild(oldScreen)
			}
			
			_screenSet[id] = screen
			showScreen(screen)
		}
		
		public function hideNamedScreen(id:String):void
		{
			if (id in _screenSet)
			{
				hideScreen(_screenSet[id])
			}
			else
			{
				throw new Error('ID ('+ id +') does not exist')
			}
		}
	}
}
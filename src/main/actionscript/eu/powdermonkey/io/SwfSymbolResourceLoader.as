package eu.powdermonkey.io
{
	import flash.events.Event;

	public class SwfSymbolResourceLoader implements IResource
	{
		private var swf:SWFResourceLoader
		
		private var _symbolName:String
		
		private var _failure:Error
		
		public function SwfSymbolResourceLoader(swf:SWFResourceLoader, symbolName:String)
		{
			this.swf = swf
			_symbolName = symbolName
			
			if (swf.isLoaded)
			{
				validate()
			}
			else
			{
				swf.addEventListener(
					Event.COMPLETE, 
					function (event:Event):void 
					{ 
						validate() 
					},
					false,
					1
				)
			}
		}
		
		private function validate():void
		{
			if (swf.hasDefinition(symbolName))
			{
				_failure = new Error('SWF at ' + swf.url + ' does not contain the symbol ' + symbolName)
			}
		}
		
		public function get content():*
		{
			return swf.getDefinition(_symbolName)
		}
		
		public function get symbolName():String
		{
			return _symbolName
		}
		
		public function load():void
		{
			swf.load()
		}
		
		public function get id():String
		{
			return swf.id
		}
		
		public function get isLoading():Boolean
		{
			return swf.isLoaded
		}
		
		public function get isLoaded():Boolean
		{
			return swf.isLoaded
		}
		
		public function get hasFailed():Boolean
		{
			return !swf.hasDefinition(_symbolName) && swf.hasFailed
		}
		
		public function get failure():Error
		{
			return _failure
		}
		
		public function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void
		{
			swf.addEventListener(type, listener, useCapture, priority, useWeakReference)
		}
		
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean=false):void
		{
			swf.removeEventListener(type, listener, useCapture)
		}
		
		public function dispatchEvent(event:Event):Boolean
		{
			return swf.dispatchEvent(event)
		}
		
		public function hasEventListener(type:String):Boolean
		{
			return swf.hasEventListener(type)
		}
		
		public function willTrigger(type:String):Boolean
		{
			return swf.willTrigger(type)
		}
	}
}
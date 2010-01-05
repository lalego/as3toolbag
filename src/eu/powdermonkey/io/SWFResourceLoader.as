package eu.powdermonkey.io
{
	import flash.events.Event;
	import flash.system.ApplicationDomain;
	
	import mx.controls.SWFLoader;

	public class SWFResourceLoader extends ResourceLoader
	{
		private var applicationDomain:ApplicationDomain
		
		public function SWFResourceLoader(url:String, id:String=null)
		{
			super(url, null, id);
			addEventListener(
				Event.COMPLETE,
				function (event:Event):void
				{
					applicationDomain = loader.contentLoaderInfo.applicationDomain
				},
				false,
				2
			)
		}
		
		public function hasDefinition(symbolName:String):Boolean
		{
			return applicationDomain.hasDefinition(symbolName)
		}
		
		public function getDefinition(symbolName:String):Object
		{
			return applicationDomain.getDefinition(symbolName)
		}
	}
}
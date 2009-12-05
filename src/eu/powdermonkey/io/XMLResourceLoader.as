package eu.powdermonkey.io
{
	import flash.events.Event;
	import flash.net.URLVariables;
	
	public class XMLResourceLoader extends ResourceLoader
	{
		protected var _xml:XML
		
		public function XMLResourceLoader(url:String, urlVariables:URLVariables=null, id:String=null)
		{
			super(url, urlVariables, id);
			addEventListener(Event.COMPLETE, onXMLLoaded)
		}
		
		protected function onXMLLoaded(event:Event):void
		{
			try
			{
				_xml = new XML(content)
			}
			catch (error:Error)
			{
				onXMLParseFail(error)
			}
		}
		
		protected function onXMLParseFail(error:Error):void
		{
			trace(id, " XML is invalid:", error)
		}
		
		protected function get xml():XML
		{
			return _xml
		}
	}
}
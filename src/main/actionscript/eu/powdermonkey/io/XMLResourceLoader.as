package eu.powdermonkey.io
{
	import eu.powdermonkey.io.logging.methods.error;
	
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
		
		protected function onXMLParseFail(err:Error):void
		{
			error(id, " XML is invalid:", err)
		}
		
		protected function get xml():XML
		{
			return _xml
		}
	}
}
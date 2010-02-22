package eu.powdermonkey.io
{
	import flash.events.Event;
	import flash.utils.Dictionary;

	public class ResourceManifest extends XMLResourceLoader
	{
		private var _root:ResourceGroup
		
		private var loadedSwfs:Dictionary = new Dictionary()
		
		public function ResourceManifest(url:String, id:String=null)
		{
			super(url, null, id)
			addEventListener(Event.COMPLETE, onLoadingComplete)
		}
		
		private function onLoadingComplete(event:Event):void
		{
			_root = parseGroup(xml)
		}
		
		public function findResource(id:String):ILoadable
		{
			return _root.findResource(id)
		}
		
		private function parseGroup(groupXML:XML):ResourceGroup
		{
			var resources:Array = []
			
			for each (var childXML:XML in groupXML.children())
			{
				var tagName:String = childXML.name()
				
				if (childXML.children().length() > 0)
				{
					  childXML.@id = groupXML.hasOwnProperty('@id') 
					  	? groupXML.@id + '.' + tagName
					  	: tagName

					resources.push(parseGroup(childXML))
				}
				else
				{
					var id:String =  groupXML.hasOwnProperty('@id') 
							? groupXML.@id + '.' + tagName 
							: tagName
							
					resources.push(buildResource(id, childXML))  
				}
			}
			
			return new ResourceGroup(groupXML.@id, resources)
		}
		
//		private function parseGroup(groupXML:XML):ResourceGroup
//		{
//			var resourcesXMLList:XMLList = groupXML.resource
//			var resources:Array = []
//			
//			if (resourcesXMLList.length() > 0)
//			{
//				for each (var resourceXML:XML in resourcesXMLList)
//				{
//					var id:String =  groupXML.hasOwnProperty('@id') 
//						? groupXML.@id + '.' + resourceXML.@name 
//						: resourceXML.@name
//					
//					resources.push(buildResource(id, resourceXML.children()[0]))
//				}
//			}
//			
//			for each (var childGroupXML:XML in groupXML.resourceGroup)
//			{
//				if (childGroupXML.hasOwnProperty('@name'))
//				{
//					  childGroupXML.@id = groupXML.hasOwnProperty('@id') 
//					  	? groupXML.@id + '.' + childGroupXML.@name 
//					  	: childGroupXML.@name
//				}
//				
//				resources.push(parseGroup(childGroupXML))
//			}
//			
//			return new ResourceGroup(groupXML.@id, resources)
//		}
		
		private function buildResource(id:String, resourceTypeXML:XML):ILoadable
		{
			var url:String = resourceTypeXML.@url
			var postfix:String = url.match(/\.(\w+)$/)[1]
			
			if (postfix == "mp3")
			{
				return new SoundResource(url, id)
			}
			else if(postfix == "swf")
			{
				var swfLoader:SWFResourceLoader = (url in loadedSwfs) 
					? loadedSwfs[url]
					: new SWFResourceLoader(url, id)
					
				if (resourceTypeXML.hasOwnProperty('@symbol'))
				{
					return new SwfSymbolResourceLoader(swfLoader, resourceTypeXML.@symbol)
				}
				else
				{
					return swfLoader
				}
			}
			else
			{
				return new ResourceLoader(url, null, id)
			} 
		}
		
		public function get root():ResourceGroup
		{
			return _root
		}
	}
}
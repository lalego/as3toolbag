package eu.powdermonkey.io
{
	import flash.utils.Dictionary;
	
	public class ResourceGroup extends LoadingSequence
	{
		private var _id:String 
		
		private var nameToResource:Dictionary = new Dictionary()
		
		public function ResourceGroup(id:String, resources:Array)
		{
			super(resources)
			_id = id
			
			for each (var resource:ILoadable in resources)
			{
				var name:String = resource.id.match(/\.?(\w+)$/)[1]
				nameToResource[name] = resource
			}
		}
		
		override public function get id():String
		{
			return _id
		}
		
		public function findResource(id:String):ILoadable
		{
			var tokens:Array = id.split('.')
			var resource:ResourceGroup = this
			
			for each (var token:String in tokens)
			{
				if (nameToResource[token] is ResourceGroup)
				{
					resource = resource.nameToResource[token]
				}
				else
				{
					return resource.nameToResource[token]
				}
			}
			
			return resource
		}
	}		
}
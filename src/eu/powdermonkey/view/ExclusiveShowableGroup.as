package eu.powdermonkey.view
{
	import eu.powdermonkey.collections.IList;
	
	public class ExclusiveShowableGroup
	{
		private var showables:IList
		
		public function ExclusiveShowableGroup(showables:IList)
		{
			this.showables = showables
		}
		
		public function show(showThis:IShowable):void
		{
			for each (var showable:IShowable in showables)
			{
				showable.show(showable == showThis)
			}
		}
	}
}
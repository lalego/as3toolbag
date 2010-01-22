package eu.powdermonkey.maths
{
	import eu.powdermonkey.collections.ArrayList;
	import eu.powdermonkey.collections.IList;
	import eu.powdermonkey.collections.RepeaterList;
	
	public class IntSharer
	{
		public static function share(total:int, sharesNeeded:int):IList
		{
			if (total % 2 == 0 && sharesNeeded % 2 == 0)
			{
				return new RepeaterList(total / sharesNeeded, sharesNeeded)
			}
			else
			{
				return new ArrayList([])
			}
		}
	}
}
package eu.powdermonkey.view
{
	import flash.display.Sprite;
	
	import org.flexunit.Assert;
	
	public class DepthSorterTest
	{
		private var depthSorter:DepthSorter
		
		private var container:Sprite = new Sprite()
		
		private var insideA:Sprite = new Sprite()
		
		private var insideB:Sprite = new Sprite()
		
		private var outsideA:Sprite = new Sprite();
		
		[Before]
		public function setup():void
		{
			container.addChild(insideA)
			container.addChild(insideB)
			depthSorter = new DepthSorter(container)
		}
		
		[After]
		public function tearDown():void
		{
			depthSorter = null
		}
		
		[Test]
		public function shouldBeAbleToMoveBehindOfFirstElement():void
		{
			setup()
			depthSorter.move(insideB).behindOf(insideA)
			Assert.assertEquals(container.numChildren, 2)
			Assert.assertEquals(container.getChildAt(0), insideB)
			Assert.assertEquals(container.getChildAt(1), insideA)
		}
		
		[Test]
		public function shouldBeAbleToMoveInFrontOfLastElement():void
		{
			setup()
			depthSorter.move(insideB).infrontOf(insideA)
			Assert.assertEquals(container.numChildren, 2)
			Assert.assertEquals(container.getChildAt(0), insideA)
			Assert.assertEquals(container.getChildAt(1), insideB) 
		}
	}
}
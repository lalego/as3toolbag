package eu.powdermonkey.view
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	public class DisplayUtil
	{
		public static function scale(displayObject:DisplayObject, scaleAmount:Number):void
		{
			displayObject.scaleX = scaleAmount
			displayObject.scaleY = scaleAmount
		}
		
		public static function copyScale(fromDisplay:DisplayObject, toDisplay:DisplayObject):void
		{
			toDisplay.scaleX = fromDisplay.scaleX
			toDisplay.scaleY = fromDisplay.scaleY
		}
		
		public static function capture(displayObject:DisplayObject, filters:Array):Bitmap
		{
			var image:BitmapData = new BitmapData(displayObject.width, displayObject.height)
			image.draw(displayObject)
			var capture:Bitmap = new Bitmap(image)
			capture.filters = filters
			return capture
		}
		
		
		/**
		 * Moves the given displayObject to the furthest back position of the current container
		 * @param displayObject
		 */	
		public static function sendToBack(displayObject:DisplayObject):void 
		{
			var parent:DisplayObjectContainer = displayObject.parent
			parent.setChildIndex(displayObject, 0)
		}
		
		
		/**
		 * Moves the given displayObject to the furthest back position of the current container
		 * @param displayObject
		 */	
		public static function sendToFront(displayObject:DisplayObject):void 
		{
			var parent:DisplayObjectContainer = displayObject.parent
			parent.setChildIndex(displayObject, parent.numChildren-1)
		}
		
		public static function collectChildren(container:DisplayObjectContainer):Array /* of DisplayObject */
		{
			var result:Array /* of DisplayObject */ = []
			var eachChild:DisplayObject
			
			for (var index:int=0; index < container.numChildren; index++)
			{
				eachChild = container.getChildAt(index)
				result.push(eachChild)
			}
			
			return result
		}
		
		public static function filterChildren(container:DisplayObjectContainer, filterType:Class):Array /* of DisplayObject */
		{
			var result:Array /* of DisplayObject */ = []
			var eachChild:DisplayObject
			
			for (var index:int=0; index < container.numChildren; index++)
			{
				eachChild = container.getChildAt(index)
				
				if (eachChild is filterType)
				{
					result.push(eachChild)
				}
			}
			
			return result
		}
		
		/**
		 * @param displayObject The DisplayObject to center relative to the stage.
		 * This will only happen if  the DisplayObject is actually attached to the stage.
		 * @return True if  the DisplayObject was centered, False if  it was not due to it not being attached to the stage
		 */	
		public static function centerToStage(displayObject:DisplayObject):Boolean 
		{
			var stageExist:Boolean = displayObject.stage != null
			
			if (stageExist)
			{
				displayObject.x = (displayObject.stage.stageWidth/2) - (displayObject.width/2)
				displayObject.y = (displayObject.stage.stageHeight/2) - (displayObject.height/2)
			}
			else
			{
				throw new Error("DisplayObject given is not attached to Stage")
			}
			
			return stageExist
		}
		
		public static function centerToBounds(displayObject:DisplayObject, width:int, height:int):void 
		{
			displayObject.x = (width * 0.5) - (displayObject.width * 0.5)
			displayObject.y = (height * 0.5) - (displayObject.height * 0.5)
		}
		
		public static function playAllMovieClips(mc:*) : void 
		{
			actionOnMovieClips(mc, 'play')
		}
		
		public static function gotoAndPlayAllMovieClips(mc:*, frame:int=1) : void 
		{
			actionOnMovieClips(mc, 'gotoAndPlay', [frame])
		}
		
		public static function stopAllMovieClips(mc:*) : void 
		{
			actionOnMovieClips(mc, 'stop')
		}
		
		public static function gotoAndStopAllMovieClips(mc:*, frame:int=1) : void 
		{
			actionOnMovieClips(mc, 'gotoAndStop', [frame])
		}
		
		public static function actionOnMovieClips(mc:*, action:String, args:Array=null) : void 
		{
			if (args == null) args = []
			
			if(mc is MovieClip)
			{	
				if (args.length > 0)
				{
					mc[action].apply(null, args);
				}
				else
				{
					mc[action]()
				}
			}
			for (var i:int = 0; i < mc.numChildren; i++)
			{
				if (mc.getChildAt(i) is MovieClip)
				{
					actionOnMovieClips(mc.getChildAt(i), action, args);
				}
			}
		}
		
		public static function injectStopScript(clip:MovieClip):void
		{
			clip.addFrameScript(
				clip.totalFrames-1,
				function ():void
				{
					clip.stop()
				} 
			)
		}
		
		public static function injectStopAndResetScript(clip:MovieClip):void
		{
			clip.addFrameScript(
				clip.totalFrames-1,
				function ():void
				{
					clip.gotoAndStop(1)
				} 
			)
		}
		
		public static function createRectangleFromBounds(clip:DisplayObject, color:int=0x0000FF):Sprite
		{
			var rectangle:Sprite = new Sprite()
			rectangle.graphics.beginFill(color)
			rectangle.graphics.drawRect(0, 0, clip.width, clip.height)
			rectangle.graphics.endFill()
			rectangle.x = clip.x
			rectangle.y = clip.y
			return rectangle
		}
		
		/**
		 * Searches for a clip with the type matching the given Class, searching only upwards 
		 * from the given clip (including itself)
		 *  
		 * @param type Class were looking for
		 * @param clip the clip to start the search from. This is also included in the search
		 * @return The first clip that matches the given type or null if  no clips match 
		 * 
		 */	
		public static function findAncestorClipOfType(type:Class, clip:DisplayObject):* 
		{
			var ancestor:DisplayObject = clip 
			var clipFound:DisplayObject
			
			while (ancestor != null)
			{
				if (ancestor is type)
//				if (Class.isType(ancestor, type))
				{
					clipFound = ancestor
					break
				}
				else
				{
					ancestor = ancestor.parent
				}
			}
			
			return clipFound
		}
	}
}
package eu.powdermonkey.utils
{
	import caurina.transitions.Equations;
	
	import eu.powdermonkey.maths.Bounds;
	
	import flash.display.Sprite;
	import flash.geom.Point;
	
	import nl.interactivespaces.kijker.view.landscape.TwoPartTween;
	import nl.interactivespaces.kijker.view.utils.DisplayUtil;

	public class GraphDebug extends Sprite
	{
		private static const Resolution:int = 200
		
		private static var _instance:GraphDebug
		
		public static function displayUnit(unit:Number):void
		{
			if (_instance != null)
			{
				_instance.showUnit(unit)
			}
		}
		
		private var _unitLayer:Sprite
		
		private var _tween:TwoPartTween
		
		public function GraphDebug(tween:TwoPartTween)
		{
			_instance = this
			_tween = tween
			
			var graph:Sprite = DisplayUtil.createRectangleFromBounds(
				new Bounds(Resolution, Resolution), 
				0xCCCCCC
			)
			
			_unitLayer = new Sprite()
			var filler:Sprite = DisplayUtil.createRectangleFromBounds(
				new Bounds(Resolution, Resolution), 
				0xFFFFFF
			)
			filler.visible = false
			_unitLayer.addChild(filler)
			
			var points:Array = []
			
			for (var i:int = 0; i <= Resolution; ++i)
			{
				var unit:Number = i/Resolution
				var result:Number = _tween.calculate(unit)
				points.push(new Point(i, result * Resolution))
			}
			
			graph.graphics.lineStyle(2, 0xFF6600)
			graph.graphics.moveTo(points[0].x, Resolution - points[0].y)
			
			for (var p:int = 1; p < points.length; ++p)
			{
				var currentPoint:Point = points[p]
				graph.graphics.lineTo(currentPoint.x, Resolution - currentPoint.y)
			}
			
			addChild(graph)
			addChild(_unitLayer)
		}
		
		public function showUnit(unit:Number):void
		{
			_unitLayer.graphics.clear()
			var point:Point = new Point(
				unit * Resolution, 
				Resolution - _tween.calculate(unit) * Resolution
			)
			_unitLayer.graphics.beginFill(0xFF6600)
			_unitLayer.graphics.drawCircle(point.x, point.y, 5)
			_unitLayer.graphics.endFill()
		}
	}
}
package cx.flash.graphic;
import flash.display.Graphics;
import flash.geom.Point;

/**
 * ...
 * @author 
 */
class GraphicTools
{

	public static inline var CIRCLE_SEGMENT_MAX = 6.3;	
	static public inline var CIRCLE_SEGMENT_ROTATE:Float = 270;
	static public function drawCircleSegment(graphics:Graphics, center:Point, start:Float, end:Float, r:Float, h_ratio:Float=1, v_ratio:Float=1, new_drawing:Bool=true)
	{

		var x:Float = center.x;
		var y:Float = center.y;
		// first point of the circle segment
		if(new_drawing)
		{
			var xStart = x + Math.cos(start) * r * h_ratio;
			var yStart = y + Math.sin(start) * r * v_ratio;
			//trace([xStart, yStart]);
			graphics.moveTo(xStart, yStart);
		}

		// draw the circle in segments
		var segments:UInt = 8;

		var theta:Float = (end-start)/segments; 
		var angle:Float = start; // start drawing at angle ...

		var ctrlRadius:Float = r/Math.cos(theta/2); // this gets the radius of the control point
		for (i in  0...segments) 
		{
			// increment the angle
			angle += theta;
			var angleMid:Float = angle-(theta/2);
			// calculate our control point
			var cx:Float = x+Math.cos(angleMid)*(ctrlRadius*h_ratio);
			var cy:Float = y+Math.sin(angleMid)*(ctrlRadius*v_ratio);
			// calculate our end point
			var px:Float = x+Math.cos(angle)*r*h_ratio;
			var py:Float = y+Math.sin(angle)*r*v_ratio;
			// draw the circle segment
			//trace([cx, cy]);

			graphics.curveTo(cx, cy, px, py);
		}
	}
}
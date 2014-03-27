package nx3.geom;
import cx.MathTools;
using nx3.geom.Rectangles.RectanglesTools;
/**
 * ...
 * @author Jonas Nyström
 */
typedef Rectangles = Array<Rectangle>;

class RectanglesTools
{
	static public function getXIntersection(rectsA:Rectangles, rectsB:Rectangles):Float
	{
		var rectsB2 = new Rectangles();
		for (r in rectsB) rectsB2.push(r.clone());		
		function check():Float
		{
			for (ra in rectsA)
			{
				for (rb in rectsB2)
				{
					var i = ra.intersection(rb);	
					// avoid range problems!
					i.width = MathTools.round2(i.width, 8);
					if (i.width > 0) return i.width;
				}			
			}
			return 0;
		}		
		var x:Float = 0;
		var moveX:Float = check();
		while (moveX > 0)
		{
			x += moveX;
			for (r in rectsB2) r.offset(moveX, 0);			
			moveX = check();
		}		
		return x;				
	}
	
	static public function clone(rects:Rectangles):Rectangles
	{
		if (rects == null) return null;
		var result = new Rectangles();
		for (r in rects) result.push(r);
		return result;
	}
	
	static public function offset(rects:Rectangles, x:Float, y:Float)
	{
		for (r in rects) r.offset(x, y);
	}
	
	static public function unionAll(rects:Rectangles): Rectangle
	{
		if (rects == null) return null;
		if (rects.length == 1) return rects[0].clone();
		
		var r:Rectangle = rects[0].clone();
		for (i in 1...rects.length)
		{
			r = r.union(rects[i]);
		}
		return r;		
	}
	
}

package nx.display.util;
import nme.geom.Point;
import nme.geom.Rectangle;

/**
 * ...
 * @author Jonas Nyström
 */

class GeomUtils 
{
	/*
	static public function overlapX(leftRect:Rectangle, rightRect:Rectangle):Rectangle {
		if (leftRect == null) return null;
		if (rightRect == null) return null;
		var testRect:Rectangle = rightRect.clone();
		testRect.width = 1000;

		if (!leftRect.intersects(testRect)) return new Rectangle(0, 0, 0, 0);
		var newX = Math.max(leftRect.left + leftRect.width, testRect.left);
		var moveX = newX - testRect.left;
		var newY = Math.max(leftRect.top + leftRect.height, testRect.top);
		var moveY = newY - testRect.top;

		return new Rectangle(0, 0, moveX, moveY);		
		return new Point(moveX, moveY);
	}
	*/

	static public function overlapX(leftRect:Rectangle, rightRect:Rectangle):Point {
		if (leftRect == null) return null;
		if (rightRect == null) return null;
		var testRect:Rectangle = rightRect.clone();
		testRect.width = 1000;

		if (!leftRect.intersects(testRect)) return new Point(0, 0);
		var newX = Math.max(leftRect.left + leftRect.width, testRect.left);
		var moveX = newX - testRect.left;
		var newY = Math.max(leftRect.top + leftRect.height, testRect.top);
		var moveY = newY - testRect.top;

		return new Point(moveX, moveY);
	}
	
	
	
	static public function arrayOverlapX(rects1:Array<Rectangle>, rects2:Array<Rectangle>) {
		var move = 0.0;
		for (r1 in rects1) {
			for (r2 in rects2) {
				var r3 = overlapX(r1, r2);
				move = Math.max(move, r3.x);
			}
		}
		return move;
	}		
	
	
	
	
	
	static public function stretchUp(rect:Rectangle, pixels:Float) {
		rect.y -= pixels;
		rect.height += pixels;
		return rect;
	}

	static public function stretchDown(rect:Rectangle, pixels:Float) {		
		rect.height += pixels;
		return rect;
	}
	
}
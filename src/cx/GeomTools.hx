package cx;
import nme.geom.Rectangle;

/**
 * ...
 * @author Jonas Nyström
 */

class GeomTools 
{


	
	
	static public function intersection2(r1:Rectangle, r2:Rectangle):Rectangle {
		if (r1 == null) return null;
		if (r2 == null) return null;
		var r2test:Rectangle = r2.clone();
		r2test.width = 1000;

		if (!r1.intersects(r2test)) return new Rectangle(0, 0, 0, 0);
		var newX = Math.max(r1.left + r1.width, r2test.left);
		var moveX = newX - r2test.left;
		var newY = Math.max(r1.top + r1.height, r2test.top);
		var moveY = newY - r2test.top;

		return new Rectangle(0, 0, moveX, moveY);		
	}

	
	static public function rectHorizontalIntersect(r1:Rectangle, r2:Rectangle, avoidR2LeftOfR1:Bool=true):Float {
		if (r1 == null) return null;
		if (r2 == null) return null;
		
		var r2test:Rectangle = r2.clone();
		if (avoidR2LeftOfR1) {
			r2test.width = 10000;
		}

		if (!r1.intersects(r2test)) return 0; // new Rectangle(0, 0, 0, 0);
		var newX = Math.max(r1.left + r1.width, r2test.left);
		var moveX = newX - r2test.left;
		
		return moveX;
		
		//var newY = Math.max(r1.top + r1.height, r2test.top);
		//var moveY = newY - r2test.top;
		//return new Rectangle(0, 0, moveX, moveY);		
		
	}
	
	static public function rectsHorizontalIntersect(rects1:Array<Rectangle>, rects2:Array<Rectangle>, avoidR2LeftOfR1:Bool = true):Float {		
		var moveX = 0.0;
		for (rect1 in rects1) {
			for (rect2 in rects2) {				
				moveX = Math.max(rectHorizontalIntersect(rect1, rect2, avoidR2LeftOfR1), moveX);
			}			
		}
		return moveX;
	}
	
	
	
}


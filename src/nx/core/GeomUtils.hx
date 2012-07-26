package nx.core;

/**
 * ...
 * @author Jonas Nyström
 */

class GeomUtils 
{

	/*
	 * *********************************************************
	 * CONSTRUCTOR
	 * *********************************************************
	 *
	*/
	
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
	
	/*
	 * *********************************************************
	 * 
	 * *********************************************************
	 *
	*/	
	

	
}
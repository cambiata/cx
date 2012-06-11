package cx.test;
import cx.geom.TestPolyRect;
import haxe.unit.TestCase;
import haxe.unit.TestRunner;
import nme.geom.Rectangle;

/**
 * ...
 * @author Jonas Nyström
 */

class GeomToolsTest extends TestCase
{
	static public function main() {		
		trace('geomTools');
		var pr = new TestPolyRect([new Rectangle(0, 0, 10, 10), new Rectangle(0, 20, 5, 5)]);		
		var r = new TestRunner();
		r.add(new Test());
		r.run();
	}
	
	//-----------------------------------------------------------------------------------------------------
	
}

import haxe.unit.TestCase;
class Test extends TestCase {	
	public function testRectHorizontalIntersect() {
		var r1 = new Rectangle(0, 0, 10, 10);		
		assertEquals(5.0,  GeomTools.rectHorizontalIntersect(r1 , new Rectangle(5, 0, 10, 10)));
		assertEquals(0.0,  GeomTools.rectHorizontalIntersect(r1 , new Rectangle(10, 0, 10, 10)));
		assertEquals(0.0,  GeomTools.rectHorizontalIntersect(r1 , new Rectangle(11, 0, 10, 10)));
		assertEquals(10.0,  GeomTools.rectHorizontalIntersect(r1 , new Rectangle(0, 0, 10, 10)));
		assertEquals(11.0,  GeomTools.rectHorizontalIntersect(r1 , new Rectangle(-1, 0, 10, 10)));
		assertEquals(11.0,  GeomTools.rectHorizontalIntersect(r1 , new Rectangle(-1, 0, 10, 10), false));		
		assertEquals(20.0,  GeomTools.rectHorizontalIntersect(r1 , new Rectangle(-10, 0, 10, 10)));
		assertEquals(0.0,  GeomTools.rectHorizontalIntersect(r1 , new Rectangle(-10, 0, 10, 10), false));
		assertEquals(0.0,  GeomTools.rectHorizontalIntersect(r1 , new Rectangle(0, 10, 10, 10)));		
		assertEquals(0.0,  GeomTools.rectHorizontalIntersect(r1 , new Rectangle(0, -10, 10, 10)));		
		assertEquals(10.0,  GeomTools.rectHorizontalIntersect(r1 , new Rectangle(0, -10, 10, 11)));		
	}

	public function testRectsHorizontalIntersect() {		
		var rects1 = [new Rectangle(0, 0, 10, 10)];		
		assertEquals(5.0,  GeomTools.rectsHorizontalIntersect(rects1 , [new Rectangle(5, 0, 10, 10)]));
		assertEquals(10.0,  GeomTools.rectsHorizontalIntersect(rects1 , [new Rectangle(0, -10, 10, 11)]));			
		
		var rects1 = [new Rectangle(0, 0, 10, 10), new Rectangle(10, -5, 5, 10)];		
		assertEquals(0.0,  GeomTools.rectsHorizontalIntersect(rects1 , [new Rectangle(15, 0, 10, 10)]));		
		assertEquals(5.0,  GeomTools.rectsHorizontalIntersect(rects1 , [new Rectangle(10, 0, 10, 10)]));		
		assertEquals(5.0,  GeomTools.rectsHorizontalIntersect(rects1 , [new Rectangle(10, -10, 10, 10)]));		
		assertEquals(0.0,  GeomTools.rectsHorizontalIntersect(rects1 , [new Rectangle(10, -15, 10, 10)]));		
		assertEquals(0.0,  GeomTools.rectsHorizontalIntersect(rects1 , [new Rectangle(0, -15, 10, 10)]));		
		assertEquals(15.0,  GeomTools.rectsHorizontalIntersect(rects1 , [new Rectangle(0, -10, 10, 10)]));		
		assertEquals(0.0,  GeomTools.rectsHorizontalIntersect(rects1 , [new Rectangle(0, -10, 10, 10)], false));		

		assertEquals(0.0,  GeomTools.rectsHorizontalIntersect(rects1 , [new Rectangle(15, 0, 10, 10), new Rectangle(15, -10, 10, 10)]));	
		assertEquals(5.0,  GeomTools.rectsHorizontalIntersect(rects1 , [new Rectangle(10, 0, 10, 10), new Rectangle(10, -10, 10, 10)]));	
		assertEquals(0.0,  GeomTools.rectsHorizontalIntersect(rects1 , [new Rectangle(10, -15, 10, 10), new Rectangle(10, -25, 10, 10)]));	
		assertEquals(5.0,  GeomTools.rectsHorizontalIntersect(rects1 , [new Rectangle(10, -14, 10, 10), new Rectangle(10, -24, 10, 10)]));	
		assertEquals(5.0,  GeomTools.rectsHorizontalIntersect(rects1 , [new Rectangle(10, -14, 10, 10), new Rectangle(10, -24, 10, 10)]));	
	}
	
}
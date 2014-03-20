package;
import cx.ArrayTools;
import cx.MathTools;
import nx3.geom.Rectangle;
import nx3.geom.Rectangles;
import nx3.test.TestN;
import nx3.test.TestQ;
import nx3.test.TestV;
import nx3.test.TestVRender;

import haxe.unit.TestCase;
import haxe.unit.TestRunner;


/**
 * ...
 * @author Jonas Nyström
 */

 using cx.ArrayTools;
 
class Main
{
	static public function main() 
	{
		var a = 0.0000000001;
		var b = MathTools.round2(a, 6);
		trace(b);
		
		
		var r1 = new Rectangle( -5, -5, 2.6, 6);
		var r2 = new Rectangle( -2.4000000000000004, -3, 3.2, 6);
		var i = RectanglesTools.getXIntersection([r1], [r2]);
		trace(i);
		
		var r1 = new Rectangle( -5, -5, 2.6, 6);
		var r2 = new Rectangle( -2.4, -3, 3.2, 6);
		var i = RectanglesTools.getXIntersection([r1], [r2]);
		trace(i);		
		
		
		
		
		var runner = new  TestRunner(); 
		runner.add(new TestQ());
		runner.add(new TestN());
		runner.add(new TestV());
		runner.add(new TestVRender());
		//runner.add(new TestDVoice());
		//runner.add(new TestDPart());
		var success = runner.run();
		
	}
}

	

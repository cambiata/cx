package cx.test;
import cx.MathTools;
import cx.StrTools;
import haxe.unit.TestCase;

/**
 * ...
 * @author Jonas Nyström
 */
using cx.StrTools;
using cx.MathTools;
class StrToolsTest extends TestCase
{

	public function testSimilar1() {		
		assertEquals('jonas'.similarity('jonas'), 1);
		assertEquals('jonas'.similarity('jonax'), 0.8);
		assertEquals('jonas'.similarity('xonas'), 0.8);
		
		assertEquals('jonas'.similarity('jonxx'), 0.6);
		assertEquals('jonas'.similarity('xxnas'), 0.6);
		
		assertEquals('jonas'.similarity('jonaxs').round2(3), 0.883);
		assertEquals('jonas'.similarity('jxonas').round2(3), 0.783);		
		
		//assertEquals(MathTools.round2(123.123456), 123.12);
		
	}
	
	public function testAssymetric() {
		assertEquals(StrTools.similarityAssymetric('jonas', 'insidejonas'), 1);
	}
	
	public function testCase() {
		assertEquals(StrTools.similarityCaseIgnore('jonas', 'Jonas'), 1);
	}
	
}
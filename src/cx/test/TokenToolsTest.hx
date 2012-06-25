package cx.test;
import cx.TokenTools;
import haxe.unit.TestCase;
import haxe.unit.TestRunner;

/**
 * ...
 * @author Jonas Nyström
 */

class TokenToolsTest 
{
	static public function main() {
		trace('TokenToolsTestx');
		var r = new TestRunner();
		r.add(new Test());
		r.run();
	}
	
}

import haxe.unit.TestCase;
class Test extends TestCase {	
	
	public function testOne() 
	{
		assertTrue(true);
		var user1 =  { u:'Jonas', p:'123', e:Date.now() };
		var token = TokenTools.getToken( user1 );
		var user2 = TokenTools.getUser(token);
		assertEquals(Std.string(user1), Std.string(user2));
	}	
	
	public function test2() {
		var obj1 = { test:'Abc' };
		var token = TokenTools.getObjectToken(obj1);
		var obj2 = TokenTools.getTokenObject(token);
		trace(obj1);
		trace(obj2);
		trace(token);
		assertEquals(Std.string(obj1), Std.string(obj2));		
	}
	
}
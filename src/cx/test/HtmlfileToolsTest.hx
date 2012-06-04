package cx.test;
import cx.HtmlfileTools;
import haxe.unit.TestCase;

/**
 * ...
 * @author Jonas Nyström
 */

class HtmlfileToolsTest extends TestCase
{

	public function test0() {
		//var items = HtmlfileTools.getItems('<body><p>This is one p item.</p></body>');
		//var items = HtmlfileTools.getItems('<html><body><p>This is one p item.</p></body></html>');
		var items = HtmlfileTools.getItems('<p>This is one p item.</p><p>Another</p>');
	}
	
	
}
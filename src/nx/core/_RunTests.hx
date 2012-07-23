package nx.core;
import cx.TestTools;
import nx.core.display._TestDisplay;
import nx.core.element._TestElement;
import nx.output._TestRender;

/**
 * ...
 * @author Jonas Nyström
 */

class _RunTests 
{
	static public function runTests() {		
		var ret = TestTools.runTests([
			//new _TestElement(),
			new _TestDisplay(),
			//new _TestRender(),
		]);
		
		return ret;
	}
}
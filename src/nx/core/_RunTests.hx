package nx.core;
import cx.TestTools;
import nx.core.display._TestDisplay;
import nx.core.element._TestElement;
import nx.output._TestRender;
import nx.output._TestRenderDBar;

/**
 * ...
 * @author Jonas Nyström
 */

class _RunTests 
{
	static public function runTests() {		
		var ret = TestTools.runTests([
			new _TestElement(),
			new _TestDisplay(),
#if nme
			//new _TestRender(),	
			new _TestRenderDBar(),
#end
		]);
		
		return ret;
	}
}
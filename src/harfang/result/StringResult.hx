package harfang.result;

import cx.Lib;
/**
 * ...
 * @author Jonas Nyström
 */

class StringResult extends ActionResult {
	private var output:String;
	public function new(output:String) {
		this.output = output;
	}	
	override public function execute(): String {
		return this.output;
	}
}
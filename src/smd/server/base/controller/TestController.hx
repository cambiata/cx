package smd.server.base.controller;
import harfang.controller.AbstractController;
import harfang.module.Module;
import smd.server.base.result.TemploResult;

/**
 * ...
 * @author Jonas Nyström
 */

class TestController extends AbstractController {

	override public function init(module:Module):Void {
		super.init(module);
		// init things here...
	}	
	
	@URL("/test/([a-zA-Z]+)/([0-9]+)")
	public function testParam2(string:String, num:Int) {							
		return 'Test with string and num : ' + string + ' ' + num;
	}
	
	@URL("/test/([a-zA-Z]+)")
	public function testParam(string: String) {							
		return 'Test with string: ' + string;
	}	

	@URL("/test")
	public function test() {							
		return 'Test';
	}		
	
	
	@URL("/templo")
	public function templo() {							
		var context = { 
			userName  : "Nestor",
			lovesHaxe : true,
			items      : ['aaa', 'bbb', 'ccc', 'ddd', 'eee']
		};
		return new TemploResult('mypage.mtt', context);
	}		
	
	
	
}
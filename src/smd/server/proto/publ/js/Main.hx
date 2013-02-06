package smd.server.proto.publ.js;

import cx.JQueryTools;
import cx.ReflectTools;
import js.JQuery;
import js.Lib;

import smd.server.base.js.IJSController;
import smd.server.base.js.JQueryController;
import smd.server.base.js.JSContext;

/**
 * ...
 * @author Jonas Nyström
 */

class Main {
	static function main() {
		
		trace('main');
		var context = new JSContext([PageController, HomeController]);
		var uri = context.getURI();
		trace(uri);

		var controller:IJSController = context.getController(context.getURI());
		trace(controller);
	}	
}

class HomeController extends JQueryController {
	
	
}

@uri('/(page)/')
class PageController extends JQueryController {
	@id public var test:JQuery;
	@id public var btnTest:JQuery;
	
	public function new() {
		super();
		this.test.html('HEHE!');
		this.btnTest.click(function(e) {
			Lib.alert('clicked');
		});
	}
	
}



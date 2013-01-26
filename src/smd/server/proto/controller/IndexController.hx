package smd.server.proto.controller;
import harfang.controller.AbstractController;
import harfang.exception.Exception;
import smd.server.proto.Config;

/**
 * ...
 * @author Jonas Nyström
 */

class IndexController extends AbstractController
{
	@URL("^/$")
	public function home() { 			
		trace('home trace');
		return 'IndexController.home() : ' + Config.testString;
	}	
}
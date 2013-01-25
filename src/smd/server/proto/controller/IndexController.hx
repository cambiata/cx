package smd.server.proto.controller;
import harfang.controller.AbstractController;

/**
 * ...
 * @author Jonas Nyström
 */

class IndexController extends AbstractController
{
	@URL("^/$")
	public function home() { 	
		return 'home';
	}	
}
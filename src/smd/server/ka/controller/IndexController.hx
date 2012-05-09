package smd.server.ka.controller;
import smd.server.base.controller.UserController;
import smd.server.ka.result.IndexResult;

/**
 * ...
 * @author Jonas Nyström
 */

class IndexController extends UserController
{
	//@URL("/", "g")
	@URL("^/$")
	public function index() { 	
		return new IndexResult(loginUser, null, null);
	}
	
	
}
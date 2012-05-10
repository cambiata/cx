package smd.server.ka.controller;
import smd.server.base.controller.UserController;
import smd.server.ka.result.IndexResult;

/**
 * ...
 * @author Jonas Nyström
 */

class IndexController extends UserController
{
	@URL("^/$")
	public function index() { 	
		return new IndexResult(this.authUser, null, null);
	}
}
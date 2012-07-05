package smd.server.ka.controller;
import cx.ConfigTools;
import cx.Web;
import smd.server.base.controller.UserController;
import smd.server.ka.config.Config;
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
	
	@URL("/config")
	public function config() {		
		var a = 1 / 0;
		return Config.configFile;		
	}
	
	
}
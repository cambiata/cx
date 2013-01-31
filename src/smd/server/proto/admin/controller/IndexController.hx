package smd.server.proto.admin.controller;
import cx.ValidationTools;
import harfang.controller.AbstractController;
import harfang.exception.Exception;
import neko.Lib;
import neko.Web;
import smd.server.base.result.TemploResult;
import smd.server.proto.base.controller.UserController;

/**
 * ...
 * @author Jonas Nyström
 */

class IndexController extends UserController
{
	
	@URL("^/$")
	public function index() { 
		if (Context.user == null) return new TemploResult('start.mtt', Context, Config.filesPath);
		return new TemploResult('home.mtt', Context, Config.filesPath);
	}		
	
	
}
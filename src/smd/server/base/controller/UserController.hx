package smd.server.base.controller;

import cx.Web;
import harfang.controller.AbstractController;
import harfang.module.Module;
import haxe.Firebug;
import smd.server.base.auth.AuthResult;
import smd.server.base.auth.AuthUser;
import smd.server.base.SiteState;
import smd.server.ka.auth.KaAuth;
import smd.server.base.auth.AuthTools;

/**
 * ...
 * @author Jonas Nyström
 */

class UserController extends AbstractController {
	private var authUser:AuthUser;
	
	override public function init(module:Module):Void {
		super.init(module);
		this.authUser = SiteState.user;
	}	
}

package smd.server.proto.base.controller;
import harfang.controller.AbstractController;
import neko.Web;
import smd.server.base.result.TemploResult;
import smd.server.proto.lib.user.User;
import smd.server.proto.lib.user.UserCategory;

/**
 * ...
 * @author Jonas Nyström
 */

class UserController extends AbstractController
{
	
	override public function handleBefore() {		
		
	}
	
	public function accessControl():UserCategory {		
		if (Context.user != null) return Context.user.category;
		return UserCategory.Anonym;		
	}
	
	
	/*
	@URL("/start")
	public function start() { 							
		return new TemploResult('start.mtt', Context, Config.filesPath);
	}
	*/
	
}
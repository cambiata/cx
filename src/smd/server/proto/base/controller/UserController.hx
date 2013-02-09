package smd.server.proto.base.controller;
import harfang.controller.AbstractController;
import neko.Web;
import smd.server.base.result.TemploResult;

/**
 * ...
 * @author Jonas Nyström
 */

class UserController extends AbstractController
{
	
	override public function handleBefore() {		
		
	}
	
	public function accessControl():String {		
		if (Context.user != null) return Context.user.category;
		return '';		
	}
	
	
	/*
	@URL("/start")
	public function start() { 							
		return new TemploResult('start.mtt', Context, Config.filesPath);
	}
	*/
	
}
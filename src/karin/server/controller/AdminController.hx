package karin.server.controller;
import harfang.controller.AbstractController;
import karin.Config;
import karin.Context;
import neko.Web;
import smd.server.proto.lib.user.UserCategory;

import smd.server.base.result.TemploResult;
/**
 * ...
 * @author Jonas Nyström
 */
class AdminController extends AbstractController
{

	public function new() 
	{
	}
	
	@URL("/admin/users")
	public function users() { 			
		if (Context.user == null) Web.redirect('/');
		if (Context.user.category != Std.string(UserCategory.Admin)) Web.redirect('/');
		
		return new TemploResult('admin-users.mtt', Context, Config.filesPath);
	}	
	
	@URL("/admin/roadmap")
	public function roadmap() { 			
		if (Context.user == null) Web.redirect('/');
		if (Context.user.category != Std.string(UserCategory.Admin)) Web.redirect('/');
		
		return new TemploResult('admin-roadmap.mtt', Context, Config.filesPath);
	}	
	
}
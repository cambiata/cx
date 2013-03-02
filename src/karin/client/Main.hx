package karin.client;
import haxe.remoting.HttpAsyncConnection;
import haxe.Serializer;
import haxe.Unserializer;
#if haxe3
import js.Browser;
#else

#end

import js.Lib;
import js.JQuery;
import smd.server.proto.lib.user.User;
import smd.server.proto.lib.user.UserCategory;
import karin.client.controller.HomeController;
import karin.client.controller.UserController;
import karin.client.controller.admin.UsersController;
import karin.client.controller.admin.RoadmapController;
import micromvc.client.Context;


/**
 * ...
 * @author Jonas Nyström
 */

class Main 
{
	static public function main() new Main()  #if haxe3 ; #end
	
	public function new() 
	{		
		#if haxe3
		var contextUserData = Reflect.field(Browser.window, 'CONTEXT_USER');			
		#else
		var contextUserData = Reflect.field(Lib.window, 'CONTEXT_USER');			
		#end
		
		var user:User = Unserializer.run(contextUserData);
		trace(user);
		
		var controllers:Array<Dynamic> = [];
		
		if (user == null) {
			controllers.push(HomeController);
		} else if(user.category == Std.string(UserCategory.Admin)) {
			controllers.push(RoadmapController);
			controllers.push(UsersController);
			controllers.push(UserController);
		} else if (user.category == Std.string(UserCategory.Deltagare)) {
			controllers.push(UserController);			
		}
		var context = new Context(controllers);   		
			
	}
	
}


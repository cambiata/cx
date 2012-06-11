package smd.rest;
import cx.CryptTools;
import cx.StrTools;
import cx.ReflectTools;
import cx.TokenTools;
import neko.Web;
import smd.rest.controller.HomeController;
import smd.rest.controller.LoginController;

/**
 * ...
 * @author Jonas Nyström
 */

class Server 
{
	static public function main() 
	{		
		//trace(Date.fromTime(Date.now().getTime() + 1000 * 60 * 60));
		
		
		var tUser = checkAuth();
		//trace(tUser);
		
		//-----------------------------------------------------------------------------------------------------		
		var controllerPath = 'smd.rest.controller.';		
		var uri = Web.getURI();
		var uriSegments = StrTools.splitTrim(uri, '/');
		var c = uriSegments.shift();
		var controller = ( (c != null) ? StrTools.firstUpperCase(c) : 'Home') + 'Controller';		
		var m = uriSegments.shift();		
		var method = (m != null) ? Web.getMethod().toLowerCase() + StrTools.firstUpperCase(m) : 'getIndex';
		var parameters = uriSegments;				
		//try {
			var controllerInstance = Type.createInstance(Type.resolveClass(controllerPath + controller), []);
			var result = ReflectTools.callMethod(controllerInstance, method, parameters);
			trace(result);
		/*
		} catch (d:Dynamic) {
			trace('ERROR');
			trace([controller, method, parameters]);
			trace(Web.getMethod());
			trace(Web.getClientHeaders());
		}	
		*/
	}
	
	static public function checkAuth() {		
		var tUser = { u:null, p:null, e:null };
		var token = '';
		try {
			token = Web.getParams().get('auth');
			if (token == null) {
				token = Web.getClientHeader('Auth');
			}
			tUser = TokenTools.getUser(token);
			return tUser;			
		} catch (e:Dynamic) {
			//trace('token error');	
			//trace(token);
			return null;
		}
		return tUser;
	}
	
}


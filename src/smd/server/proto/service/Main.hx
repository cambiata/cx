package smd.server.proto.service;
import cx.PathTools;
import cx.RttiTools;
import micromvc.server.Context;
import neko.Web;

import micromvc.server.Controller;

/**
 * ...
 * @author Jonas Nyström
 */
using cx.PathTools;
class Main 
{
	public static function main() 
	{
		var uri = Web.getURI().addSlash().addSlashBefore();
		trace('service: ' + uri);
		var context = new Context([TestController, HomeController]);
	}
	
}

class HomeController implements Controller {
	public function new() {
		trace('NEW HomeController');
	}	
	
	public function index() {
		trace('index method');
	}
	
	@action 
	public function hej() {
		trace('hej method');
	}
}

@uri('/test/')
class TestController implements Controller {
	public function new() {
		trace('NEW TestController');
	}
	
	@action 
	public function apa() {
		trace('action apa');
	}
	
	@action('kossa/mu') 
	public function ko(a, b) { 
		trace(['action ko', a, b]);
	}
	
	public function index() {
		trace('index method');
	}
	
}
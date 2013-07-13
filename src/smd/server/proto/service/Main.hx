package smd.server.proto.service;
import cx.ConfigTools;
import cx.PathTools;
import cx.RttiTools;
import haxe.Firebug;
import haxe.Json;
import haxe.Log;
import haxe.Serializer;
import micromvc.server.Context;
import neko.Lib;
import neko.Web;
import smd.server.proto.Config;
import smd.server.proto.lib.db.DBChoirUser;
import smd.server.proto.lib.db.DBUser;
import smd.server.proto.lib.ScorxDBTools;
import smd.server.proto.lib.db.TUserBox;
import smd.server.proto.lib.db.TUserBoxes;
import sys.db.Connection;

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
		
		Log.trace = Firebug.trace;
		ConfigTools.loadConfig(Config, Config.configFile);		
		var uri = Web.getURI().addSlash().addSlashBefore();
		Web.setHeader('Access-Control-Allow-Origin', '*');
		var context = new Context([UserdataController, TestController, HomeController]);
		
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
	public function user() {
		trace('action USER');
	}
	
	@action('order/spec') 
	public function order(a, b) { 
		trace(['action ORDER', a, b]);
	}
	
	public function index() {
		trace('index method');
	}	
}

class ResultController implements Controller {
	public function new() {
		
	}
	
	private function output(result:ServiceResult, httpCode:Int=200) {		
		var out = Json.stringify(result);
		Lib.print(out);
	}
}


@uri('/user/')
class UserdataController extends ResultController  {
	private var cnx:Connection;
	public function new() {
		super();
		//trace('NEW UserdataController');		
		this.cnx = ScorxDBTools.getCnx(Config.filesPath + 'data/scorx.sqlite');
		//ScorxDBTools.createTables(cnx);
	}

	public function index() {
		trace('index method');
	}	
	
	@action('boxes') 
	public function boxes(userid:String) {
		//trace(userid);
		
		var boxid = Web.getParams().get('boxid');		
		var userBoxes = ScorxDBTools.getTUserBoxes(userid);
		
		if (boxid != null) {
			//trace('boxid:' + boxid);
			var newBoxes = new TUserBoxes();
			for (userBox in userBoxes) {
				if (userBox.box.id == boxid) {
					newBoxes.push(userBox);
				}
			}
			userBoxes = newBoxes;			
		}
		
		this.output(ServiceTool.toResult('boxes for user ' + userid, Serializer.run(userBoxes)));
		return;
	}
	
	@action('box') 
	public function box(userid:String, boxid:String) {
		//trace([userid, boxid]);		
		
		var userBoxes = ScorxDBTools.getTUserBoxes(userid);
		
		var uBox:TUserBox=null;
		for (userBox in userBoxes) {
			uBox = userBox;
			if (userBox.box.id == boxid) break;
			uBox = null;
		}
		
		// Error?
		if (uBox == null) {
			this.output(ServiceTool.toResult('No box for user ' + userid + '/' + boxid, null, 1, 'NO VALID BOX'));			
			return;
		}
		
		// Ok!
		var ids = uBox.box.ids;
		var listExamples = ScorxDBTools.listExamplesGet(ids);
		//trace(listExamples);
		//trace(Json.stringify(listExamples));
		var result = ServiceTool.toResult('Box for user ' + userid + '/' + boxid, Serializer.run(uBox), 0, '', Serializer.run(listExamples));		
		this.output(result);
	}	

	
	@action('info')
	public function info(userid:String) {				
		
		var user:DBUser;
		var info:String = '';
		var result:ServiceResult;
		
		try{
			user = DBUser.manager.get(userid);
			//var choirs = DBChoirUser.manager.search( { user:'11111111-1111' } );
			info = user.toString();
			result = ServiceTool.toResult('Info for user ' + userid, info);
		} catch (e:Dynamic) {
			result = ServiceTool.toResult('Error user ' + userid, Std.string(e), 1);
		}
		
		this.output(result);
	}
	
	
}
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
import sx.db.ScorxDBTools;
import sx.db.tables.TUserBox;
import sx.db.tables.TUserBoxes;
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
		//trace('service: ' + uri);
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

@uri('/user/')
class UserdataController implements Controller  {
	private var cnx:Connection;
	public function new() {
		
		//trace('NEW UserdataController');		
		this.cnx = ScorxDBTools.getCnx(Config.filesPath + 'data/scorx.sqlite');
		//ScorxDBTools.createTables(cnx);
		
	}

	public function index() {
		trace('index method');
	}	
	
	@action('boxes') 
	public function boxes(userid:String) {
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
		
		//Lib.print(Serializer.run(userBoxes));	
		var out = Serializer.run(ServiceTool.toResult('boxes for user ' + userid, Serializer.run(userBoxes)));
		Lib.print(out);
		
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
		
		if (uBox == null) {
			var out = Serializer.run(ServiceTool.toResult('No box for user ' + userid + '/' + boxid, null, 1, 'NO VALID BOX'));
			Lib.print(out);
			return;
		}
		
		//trace(uBox);
		var ids = uBox.box.ids;
		//trace(ids);
		var listExamples = ScorxDBTools.listExamplesGet(ids);
		
		//trace(listExamples);
		
		var result = ServiceTool.toResult('Box for user ' + userid + '/' + boxid, Serializer.run(uBox), 0, '', Serializer.run(listExamples));
		//trace(result);
		var out = Serializer.run(result);
		Lib.print(out);
		/*
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
		*/
		
		//Lib.print(Serializer.run(userBoxes));	
		/*
		var out = Serializer.run(ServiceTool.toResult('boxes for user ' + userid, Serializer.run(userBoxes)));
		Lib.print(out);
		*/
	}	
	
	
}
package smd.server.proto.tools;

//import cx.SqliteTools;
import micromvc.client.Context;

import neko.Lib;
import ka.db.DBTools;
import sys.db.SpodInfos;
import sys.db.Sqlite;
import sys.db.TableCreate;

/**
 * ...
 * @author Jonas Nyström
 */

class Main 
{
	static public function main() 
	{
		trace('tools');
		var cnx = DBTools.getCnx('test.sqlite');		
		DBTools.deleteTables(cnx);
		DBTools.createTables(cnx);
		DBTools.createDefaultData(cnx);		
		var context = new Context([TestController, HomeController], null);
	}	
}

import micromvc.client.Controller;

@method('get')
class HomeController implements Controller {
	public function new() {
		trace('HomeController');		
	}	
}

@uri('/test/([0-9]+)/([a-z]+)/')
class TestController implements Controller {
	public function new(par:Dynamic, par2:Dynamic) {
		trace('TestController ' + Std.string(par));		
	}	
}
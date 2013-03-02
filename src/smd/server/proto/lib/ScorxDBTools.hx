package smd.server.proto.lib;
import cx.FileTools;
import cx.PathTools;
import haxe.Serializer;
import haxe.Unserializer;
import smd.server.proto.lib.db.DBUser;
import smd.server.proto.lib.db.DBBox;
import smd.server.proto.lib.db.DBListExamples;
import smd.server.proto.lib.db.DBUserBox;
import smd.server.proto.lib.db.TUserBoxes;
import sx.type.TListExample;
import sx.type.TListExamples;
import sys.db.Connection;
import sys.db.Object;
import sys.db.Sqlite;
import sys.db.TableCreate;
import sys.FileSystem;

/**
 * ...
 * @author Jonas Nyström
 */

 
using StringTools;
class ScorxDBTools 
{

	static public function getCnx(filename:String):Connection {
		if (!FileSystem.exists(filename)) throw filename + ' does not exist';
		var cnx = Sqlite.open(filename);
		sys.db.Manager.cnx = cnx;				
		sys.db.Manager.initialize();
		return cnx;
	}	

	static public function createTables(cnx:Connection) {	
		if (!TableCreate.exists(DBListExamples.manager)) TableCreate.create(DBListExamples.manager);
		if (!TableCreate.exists(DBBox.manager)) TableCreate.create(DBBox.manager);
		if (!TableCreate.exists(DBUserBox.manager)) TableCreate.create(DBUserBox.manager);
		if (!TableCreate.exists(DBUser.manager)) TableCreate.create(DBUser.manager);
	}

	
	//--------------------------------------------------------
	
	static public function listExamplesInsert(listExamples:TListExamples) {
		for (listExample in listExamples) {
			var dbItem = new DBListExamples();
			dbItem.id = listExample.id;
			dbItem.info = listExample.title;
			dbItem.data = Serializer.run(listExample);
			dbItem.insert();
		}		
	}
	
	static public function listExamplesGetAll():TListExamples {
		var dbItems = DBListExamples.manager.all();
		var listExamples = new TListExamples();
		for (dbItem in dbItems) {
			listExamples.set(dbItem.id, Unserializer.run(dbItem.data));
		}
		return listExamples;
	}
	
	static public function listExampleGet(id:Int):TListExample {
		var dbItem = DBListExamples.manager.get(id);
		var listExample:TListExample = Unserializer.run(dbItem.data);
		return listExample;
	}
	
	static public function listExamplesGet(ids:Array<Int>):TListExamples {
		var listExamples = new TListExamples();
		for (id in ids) {
			listExamples.set(id, listExampleGet(id));
		}
		return listExamples;
	}
	
	//----------------------------------------------------------------------
	
	static public function getTUserBoxes(userid:String):TUserBoxes {
		/*
		var result:TUserBoxes = [];
		var items = DBUserBox.manager.search($uid == userid);
		for (item in items) {			
			result.push(item.toTUserBox());
		}		
		return result;
		*/
		return null;
	}
	
	//----------------------------------------------------------------------
	
	static public function setDBPragma(cnx:Connection) {
		var sql = 'PRAGMA foreign_keys = ON;';
		cnx.request(sql);
	}
	
	static private function getClassName(klass:Class<Object>):String {
		return PathTools.lastSegment(Type.getClassName(klass), '.');
	}
	
	static public function createTable(cnx:Connection, klass:Class<Object>, path:String) {		
		var sqls = FileTools.getContent(path + getClassName(klass) + '.create.sql').split(';');
		for (sql in sqls) {
			if (sql.trim() != '') cnx.request(sql);
		}
	}
	
	static public function defaultData(cnx:Connection, klass:Class<Object>, path:String) {
		var sqls = FileTools.getContent(path + getClassName(klass) + '.default.sql').split(';');
		for (sql in sqls) {
			if (sql.trim() != '') cnx.request(sql);
		}
	}
	
	
}
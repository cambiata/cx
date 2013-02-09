package sx.db;
import cx.Sys;
import haxe.Serializer;
import haxe.Unserializer;
import sx.db.tables.DBBox;
import sx.db.tables.DBListExamples;
import sx.db.tables.DBUserBox;
import sx.db.tables.TUserBoxes;
import sx.type.TListExample;
import sx.type.TListExamples;
import sys.db.Connection;
import sys.db.Sqlite;
import sys.db.TableCreate;
import sys.FileSystem;

/**
 * ...
 * @author Jonas Nyström
 */

 

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
		var result:TUserBoxes = [];
		var items = DBUserBox.manager.search($userid == userid);
		for (item in items) {			
			result.push(item.toTUserBox());
		}		
		return result;
	}
}
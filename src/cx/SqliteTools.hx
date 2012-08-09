package cx;

import neko.db.Sqlite;

import neko.FileSystem;
/**
 * ...
 * @author Jonas Nyström
 */

class SqliteTools {	
	
	static public function getCnx(sqliteFilename:String):neko.db.Connection {
		return neko.db.Sqlite.open(sqliteFilename); 
	}
	
	static public function select(sqliteFilename:String, sql:String) {
		return getCnx(sqliteFilename).request(sql).results();		
	}
	
	static public function insert(sqliteFilename:String, sql:String) {
		var cnx = getCnx(sqliteFilename);
		cnx.request(sql);
		return cnx.lastInsertId();
	}

	static public function getInsertStatement(insertObject:Dynamic, tableName:String) {
		var fields = Reflect.fields(insertObject);
		var sql = '(' + fields.join(', ') + ')';
		sql += ' VALUES ';
		
		var values = new Array<String>();
		for (field in fields) {			
			values.push(Reflect.field(insertObject, field));
		}		
		//sql += '("' + values.join('", "') + '")';
		sql += "('" + values.join("', '") + "')";
		return 'INSERT INTO "' + tableName + '" ' + sql;		
	}
	
	static public function execute(filename:String, sql:String) {
		var cnx = Sqlite.open(filename);	
		var results = cnx.request(sql).results();
		cnx.close();
		return results;
	}	
	
	static public function createSqlite(filename:String):Bool {
		if (FileSystem.exists(filename)) throw 'SQlite file ' + filename + ' already exists!';
		var cnx = Sqlite.open(filename);	
		cnx.close();	
		return FileSystem.exists(filename);
	}
	
}
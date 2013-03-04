package karin.db;
import cx3.ConfigTools;
import gustav.Config;
import sys.db.Connection;
import sys.db.Manager;
import sys.db.Sqlite;


/**
 * ...
 * @author Jonas Nyström
 */
class DB
{
	static public var cnx:Connection; // = getCnx();	
	
	static public function init(dbFile:String) {
		trace(dbFile);
		var cnx = Sqlite.open(dbFile);
		DB.cnx = cnx;
		Manager.cnx = cnx;
		Manager.initialize();
		return cnx;
	}
	
}
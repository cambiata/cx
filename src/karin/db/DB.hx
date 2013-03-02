package karin.db;
import cx3.ConfigTools;
import sys.db.Connection;
import sys.db.Manager;
import sys.db.Sqlite;

/**
 * ...
 * @author Jonas Nyström
 */
class DB
{
	static public var cnx:Connection = getCnx();
	
	static private function getCnx():Connection {
		ConfigTools.loadConfig(Config, Config.configFile);
		var dbFile = Config.filesPath + Config.dbFile;		
		var cnx = Sqlite.open(dbFile);
		Manager.cnx = cnx;
		Manager.initialize();
		return cnx;
	}
	
	static public function init() {
		cnx = getCnx();
	}
	
}
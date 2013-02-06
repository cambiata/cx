package smd.server.proto.tools;

//import cx.SqliteTools;
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
	}	
}

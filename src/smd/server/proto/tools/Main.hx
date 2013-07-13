package smd.server.proto.tools;

//import cx.SqliteTools;
import cx.ConfigTools;
import cx.FileTools;
import cx.PathTools;
import haxe.Int32;
import haxe.Int64;
import haxe.Serializer;
import haxe.Unserializer;
import smd.server.proto.Config;
import smd.server.proto.lib.db.BaseDB;
import smd.server.proto.lib.db.DBChoir;
import smd.server.proto.lib.db.DBChoirUser;
import smd.server.proto.lib.db.DBUser;
import smd.server.proto.lib.db.EChoirRole;
import smd.server.proto.lib.user.UserCategory;
import smd.server.proto.lib.ScorxDBTools;
import smd.server.proto.lib.db.DBBox;
import smd.server.proto.lib.db.DBListExamples;
import smd.server.proto.lib.db.DBUserBox;
import smd.server.proto.lib.db.EBoxType;
import sx.type.TListExamples;
import sx.util.ListExamplesTools;

import neko.Lib;
import ka.db.DBTools;
import sys.db.SpodInfos;
import sys.db.Sqlite;
import sys.db.TableCreate;

import sys.db.Object;
import sys.db.Types;

/**
 * ...
 * @author Jonas Nyström
 */

class Main 
{
	static public function main() 
	{
		trace('tools');		
		ConfigTools.loadConfig(Config, Config.configFile);		
		var cnx = ScorxDBTools.getCnx(Config.filesPath + Config.dbFile);
		
		//ScorxDBTools.createTables(cnx);
		
		var sqlPath = Config.filesPath + 'data/sql/';
		ScorxDBTools.setDBPragma(cnx);
		
		//if (! sys.db.TableCreate.exists(DBUser.manager) ) sys.db.TableCreate.create(DBUser.manager);
		//if (! sys.db.TableCreate.exists(DBBox.manager) ) sys.db.TableCreate.create(DBBox.manager);

		ScorxDBTools.createTable(cnx, DBUser, sqlPath);
		ScorxDBTools.defaultData(cnx, DBUser, sqlPath);
		ScorxDBTools.createTable(cnx, DBChoir, sqlPath);
		ScorxDBTools.defaultData(cnx, DBChoir, sqlPath);
		ScorxDBTools.createTable(cnx, DBChoirUser, sqlPath);
		ScorxDBTools.defaultData(cnx, DBChoirUser, sqlPath);
		ScorxDBTools.createTable(cnx, DBListExamples, sqlPath);
		ScorxDBTools.defaultData(cnx, DBListExamples, sqlPath);

		ScorxDBTools.createTable(cnx, DBBox, sqlPath);
		ScorxDBTools.defaultData(cnx, DBBox, sqlPath);
		
		if (! sys.db.TableCreate.exists(DBUserBox.manager) ) sys.db.TableCreate.create(DBUserBox.manager);
		
		var u = DBUser.manager.search( { ssnr:'22222222-2222' } ).first();
		trace(u);
		
		var choirs = DBChoirUser.manager.search( { user:u } );
		trace(choirs);
		for (choiritem in choirs) {
			var choir = DBChoir.manager.get(choiritem.choir.id);
			trace(' - ' + choir.name);
		}
		
		/*
		*/
		/*
		ScorxDBTools.createTable(cnx, DBListExamples, sqlPath);
		ScorxDBTools.defaultData(cnx, DBListExamples, sqlPath);
		*/
		
	}	
	
}



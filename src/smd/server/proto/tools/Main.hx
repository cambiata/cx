package smd.server.proto.tools;

//import cx.SqliteTools;
import cx.ConfigTools;
import cx.FileTools;
import cx.PathTools;
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
		
		ScorxDBTools.createTable(cnx, DBListExamples, sqlPath);
		ScorxDBTools.defaultData(cnx, DBListExamples, sqlPath);
		ScorxDBTools.createTable(cnx, DBUser, sqlPath);
		ScorxDBTools.defaultData(cnx, DBUser, sqlPath);
		ScorxDBTools.createTable(cnx, DBChoir, sqlPath);
		ScorxDBTools.defaultData(cnx, DBChoir, sqlPath);		
		ScorxDBTools.createTable(cnx, DBChoirUser, sqlPath);
		ScorxDBTools.defaultData(cnx, DBChoirUser, sqlPath);			

		
		var user = DBUser.manager.get('11111111-1111');
		trace(user);
		
		
		
		
		//DBChoirUser.createTable(cnx);
		/*
		var cu = new DBChoirUser();
		cu.user = user;
		cu.choir = choir;
		cu.setRole(EChoirRole.DELTAGARE);
		cu.insert();		
		*/
		
		/*
		var users = DBUser.manager.search( { user:'b', pass:'b' } );
		*/
		
		//DBChoir.createTable(cnx);
		
		/*
		var item = new DBChoir();
		item.name = 'Örnsköldsviks kammarkör';
		item.info = 'Huserar i Själevads Församling';
		item.ort = 'Själevad';
		item.lan = 'Y';
		item.insert();
		trace(item.id);
		*/
		
		/*
		var data = FileTools.getContent('scorxlist.data');
		var listExamples:TListExamples = Unserializer.run(data);
		*/
		
		//trace(listExamples);
		//ScorxDBTools.listExamplesInsert(listExamples);
		
		/*
		var listExamples = ScorxDBTools.listExamplesGetAll();
		trace(listExamples);
		var selectedExamples = ListExamplesTools.selectIds(listExamples, [17, 18, 19]);
		trace(selectedExamples);
		*/
		
		/*
		var box = new DBBox();
		box.id = 'Testbox';
		box.info = 'Här prövar vi lite grand';
		box.setIds([17, 18, 19]);
		box.setCategory(EBoxType.FREE);
		box.insert();
		*/
		
		/*
		var box = new DBBox();
		box.id = 'YourSong';
		box.info = 'Your Song - Norsk Korforbund';
		box.setIds([437,438,439,440,441,442]);
		box.setCategory(EBoxType.PROJECT);
		box.insert();
		*/
		
		/*
		var box = DBBox.manager.get('FbrFria');
		trace(box.id);
		trace(box.getIds());
		*/
		
		/*
		var userbox = new DBUserBox();
		userbox.userid = '11111111-1111';
		userbox.box = box;
		userbox.activation = Date.now();
		userbox.start = Date.fromString('2013-01-01');
		userbox.stop = Date.fromString('2013-06-30');
		userbox.info = 'Anna Andersson Fria';
		userbox.insert();
		*/
		
		//var userBoxes = ScorxDBTools.getTUserBoxes('19661222-8616');
		//trace(userBoxes);
		
	}	
	
	
	
}


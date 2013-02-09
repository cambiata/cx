package smd.server.proto.tools;

//import cx.SqliteTools;
import cx.ConfigTools;
import cx.FileTools;
import haxe.Serializer;
import haxe.Unserializer;
import smd.server.proto.Config;
import sx.db.ScorxDBTools;
import sx.db.tables.DBBox;
import sx.db.tables.DBListExamples;
import sx.db.tables.DBUserBox;
import sx.db.tables.EBoxType;
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
		trace(Config.filesPath);
		/*
		var cnx = DBTools.getCnx('test.sqlite');		
		DBTools.deleteTables(cnx);
		DBTools.createTables(cnx);
		DBTools.createDefaultData(cnx);		
		var context = new Context([TestController, HomeController], null);
		*/
		
		var cnx = ScorxDBTools.getCnx(Config.filesPath + 'scorx.sqlite');
		ScorxDBTools.createTables(cnx);
		
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
		
		var userBoxes = ScorxDBTools.getTUserBoxes('19661222-8616');
		trace(userBoxes);
		
	}	
	
	
	
}


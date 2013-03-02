package gustav;

import cx.ConfigTools;
import cx.FileTools;
import karin.db.Gustavuser;
import karin.db.Vipuser;
import g2.G2Tools;
import karin.Config;
import karin.db.DB;
import neko.Lib;
import sys.db.Sqlite;
import sys.db.Object;
import sys.db.Types;

/**
 * ...
 * @author Jonas Nyström
 */

 
class Main 
{
	
	static function main() 
	{
		
		ConfigTools.loadConfig(Config, Config.configFile);
		trace('Config filesPath ' + Config.filesPath);		
		
		var xmlFile = Config.filesPath + 'g2.xml';
		
		g2.G2Tools.getScorxPersoner(function(xmlData) {	
			trace('load from Sensus Gustav 2...');
			FileTools.putContent(xmlFile, xmlData);			
			trace('loaded!');
		});
		
		trace('parse Sensus Gustav 2...');
		var xmlData = FileTools.getContent(xmlFile);
		var users = G2Tools.getUsersFromG2Xml(Xml.parse(xmlData));
		trace(users.length);
		trace('parsed!');		
		
		//----------------------------------------
		// init karin.sqlite
		
		DB.init();
		Gustavuser.create();
		Gustavuser.deleteAll();

		var maxUsers:Int = Std.parseInt(Std.string(Config.gustavMaxUsers));
		trace('MaxUsers: ' + maxUsers);		
		var users = users.splice(0, maxUsers);			

		trace('Create Gustavusers...');
		for (user in users) {
			var u = Gustavuser.getFromGUser(user);
			u.insert();
		}
		trace('Created Gustavusers!');
		
		trace('Add vipusers...');
		Gustavuser.addVipusers();
		trace('Added vipusers!');
		
		
	}
}


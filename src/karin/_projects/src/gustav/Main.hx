package gustav;

import cx.ConfigTools;
import cx.FileTools;
import g2.db.Gustavuser;
import g2.db.Order;
import g2.G2Tools;
import karin.Config;
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
			trace('load...');
			FileTools.putContent(xmlFile, xmlData);			
			trace('loaded!');
		});
		
		
		
		trace('parse...');
		var xmlData = FileTools.getContent(xmlFile);
		var users = G2Tools.getUsersFromG2Xml(Xml.parse(xmlData));
		trace(users.length);
		trace('parsed!');		
		
		
		var g2usersFile = Config.filesPath + 'g2users.sqlite';		
		var cnx = Sqlite.open(g2usersFile);
		sys.db.Manager.cnx = cnx;
		if ( !sys.db.TableCreate.exists(Gustavuser.manager) )  sys.db.TableCreate.create(Gustavuser.manager);		
		if ( !sys.db.TableCreate.exists(Order.manager) )  sys.db.TableCreate.create(Order.manager);		
		
		Gustavuser.deleteAll(cnx);
		
		var users = users.splice(0, 10);
		trace(users.length);		
		
		for (user in users) {
			var u = Gustavuser.getFromGUser(user);
			u.insert();
		}
		
		
		/*
		var u = new Gustavuser();
		u.firstname = 'Jonas';
		u.lastname = 'Nyström';
		u.id = '196612228616';
		u.email = 'jonasnys@gmail.com';
		u.last4 = '8616';
		u.insert();
		
		var o = new Order();
		o.label = 'test';
		o.user = u;
		o.insert();
		*/
		
		//var users = GDBUser.manager.all();
		//trace(users.length);
		
	}
}


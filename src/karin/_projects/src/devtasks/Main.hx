package devtasks;

import cx.FileTools;
import cx.GoogleTools;
import cx3.ConfigTools;
import haxe.Json;
import devtasks.Config;
import karin.tools.DevtaskTools;
import karin.types.DTasks;
/*
import karin.db.DB;
import karin.db.Devtask;
import karin.db.Devtaskprio;
import karin.db.Devtaskstatus;
import karin.db.Devtasksubject;
*/
import neko.Lib;

/**
 * ...
 * @author Jonas Nyström
 */

class Main 
{	
	static function main() 
	{
		ConfigTools.loadConfig(Config, 'devtasks.conf');	
		//trace(Config.filesPath);
		
		
		/*
		var email = 'jonasnys@gmail.com';
		var passwd = '%gloria!';
		var sheetData = '0Ar0dMoySp13UdG9tMThLUVNncmpzdHNpVDVLa1FtQ1E';
		*/
		
		var g = new cx.GoogleTools.Spreadsheet(Config.email, Config.passwd, Config.sheetData);
		var cells = g.getCells();

		var dTasks:DTasks = DevtaskTools.parseData(cells);
		var json = Json.stringify(dTasks);
		FileTools.putContent(Config.filesPath + 'devtasks.json', json);
		
		//trace(dTasks);
		
		
	}
	
}
package devtasks;

import cx.FileTools;
import cx.GoogleTools;
import cx3.ConfigTools;
import haxe.Json;
import karin.Config;
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
		
		
		var email = 'jonasnys@gmail.com';
		var passwd = '%gloria!';
		var sheetData = '0Ar0dMoySp13UdDVuMWFJRFpuQW5wR054RHFiYmdPX1E';
		var g = new cx.GoogleTools.Spreadsheet(email, passwd, sheetData);
		var cells = g.getCells();
		trace(cells);
		
		ConfigTools.loadConfig(Config, Config.configFile);
		
		var json = Json.stringify(cells);
		FileTools.putContent(Config.filesPath + 'devtasks.json', json);
		
		/*
		
		trace('devtasks');		
		Devtask.cnx;
		Devtask.create();
		
		
		var d = new Devtask();
		d.started = Date.now();
		d.subject = Devtasksubject.Other;
		d.label = 'Test';
		d.status = Devtaskstatus.Started;
		d.info = '';
		d.prio = Devtaskprio.Low;
		d.insert();
		
		*/
		
	}
	
}
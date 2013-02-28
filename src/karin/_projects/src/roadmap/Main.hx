package roadmap;

import cx.FileTools;
import haxe.Json;
import neko.Lib;
//import cx.GoogleTools;
import cx3.GoogleTools.Spreadsheet;
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
		
		var g = new Spreadsheet(email, passwd, sheetData);
		var cells = g.getCells();					
		var json = Json.stringify(cells);		
		FileTools.putContent('_files/roadmap.json', json);
		
	}
	
}
package sx.app.zip.neko;

import cx.FileTools;
import cx.ZipTools;
import neko.io.Process;


import format.tools.CRC32;
import haxe.Serializer;
import haxe.Unserializer;
import neko.Lib;
import sx.type.TExample;
import sx.util.ScorxDb;
import sx.util.ScorxTools;
import sx.util.ScorxZip;

/**
 * ...
 * @author Jonas Nyström
 */

class Main 
{
	
	static private function _process(cmd:String, args:Array<String>=null) {
		if (args == null) args = [];
		var proc = new Process(cmd, args);
		try {
			while (true) {
				var line = proc.stdout.readLine();
				trace(line);				
			}
		} catch (e:Dynamic) { };		
	}
	
	static function main() 
	{
		trace('hello');
		
		var filedir = 'D:/dropbox_scorxmedia/My Dropbox/smd/smdfiles/scorx/fbr1/';
		var filename = '00000023.FBR.amatemi-ben-mio.marenzio.sqlite';
		
		var filedir = 'D:/dropbox_scorxmedia/My Dropbox/smd/smdfiles/scorx/kvintessens/';
		var filename = '00000209.alaha-ruha.nyberg.PEACE.sqlite';
		
		var example:TExample = ScorxDb.getExample(filedir + filename);
		var grid = ScorxDb.getGrid(filedir + filename);
		var quickstarts = ScorxDb.getQuickstarts(filedir + filename);
		var channels = ScorxDb.getChannels(filedir + filename);
		var pages = ScorxDb.getPages(filedir + filename);
		
		//FileTools.deleteFile('pages/');
		FileTools.deleteDirectory('pages');
		FileTools.createDirectory('pages');
		
		
		for (page in pages) {
			var pngName = 'pages/' + page.id + '.png';
			var jpgName = 'pages/' + page.id + '.jpg';						
			FileTools.putBytes(pngName, page.data);
			_process('convert', [pngName, jpgName]);
			FileTools.deleteFile(pngName);
			_process('convert', [jpgName, pngName]);
			FileTools.deleteFile(jpgName);
			page.data = FileTools.getBytes(pngName);
		}
	
		var sz = new ScorxZip('testConvertedPng.zip'); 
		sz.setExample(example);
		sz.setGrid(grid);
		sz.setQuickstarts(quickstarts);
		sz.setChannels(channels);
		sz.setPages(pages);
		sz.saveZip();
		
		/*
		var data = FileTools.getBytes('00000209.alaha-ruha.nyberg.PEACE.sqlite-130.mp3');
		trace(data.length);
		CRC32.encode(data);
		*/
		/*
		var sz2 = new ScorxZip( filename + '.zip');
		trace(sz2.getExample());
		*/

		
		
	}
	
	
	

	
}
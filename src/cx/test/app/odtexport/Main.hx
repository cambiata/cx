package cx.test.app.odtexport;

import cx.FileTools;
import cx.OdtTools;
import neko.Lib;
import neko.Sys;
import neko.Utf8;

import systools.Dialogs;

/**
 * ...
 * @author Jonas Nyström
 */

class Main 
{
	
	static function main() 
	{
	
		var filters: FILEFILTERS = 
			{ count: 1
			, descriptions: ["OpenOffice Writer file"]
			, extensions: ["*.odt"]			
			};		
		var filenames = Dialogs.openFile
			( "Select a file please!"
			, "Please select one or more files, so we can see if this method works"
			, filters 
			);
		
		
		if (filenames == null) Sys.exit(0);
		
		for (filename in filenames) {
			trace(filename);
		}		
		var directory = Dialogs.folder
			( "Select a folder"
			, "This additional message will only be shown on OSX"			
			);
		
		directory = (directory == 'null') ? null : directory;
		
		if (directory == null) {
			trace(filenames[0]);
			directory = FileTools.getDirectory(filenames[0]);
		}
		//trace(directory);
		
		if (directory == null) Sys.exit(0);
		
		for (filename in filenames) {
			trace(filename);
			var html = OdtTools.getHtmlFromOdt(filename);			
			var htmlFilename = directory + FileTools.getFilename(filename) + '.html';
			trace(htmlFilename);
			FileTools.putContentExecute(htmlFilename, html);
		}			
		
	}
	
}
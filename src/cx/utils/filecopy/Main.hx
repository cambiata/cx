package cx.utils.filecopy;

import cx.FileTools;
import cx.StrTools;
import haxe.io.Eof;
import haxe.io.Error;
import haxe.io.Path;
import neko.Lib;
import sys.FileSystem;
import sys.io.File;

/**
 * ...
 * @author 
 */

class Main 
{
	
	static function main() 
	{
		var configFileName = Sys.args()[0] ;
		if (configFileName == null) configFileName = 'config.txt';
		//trace(configFileName);
		Sys.println('--------------------------------------------');
		Sys.println('File Copy Utility');
		if (!FileSystem.exists(configFileName) ) Sys.println("Can't find config file!");
		
		var f = File.read(configFileName, false);
		try 
		{
			while (true) 
			{
				var line:String = f.readLine();
				if (StringTools.startsWith(line, '#')) continue;
				if (line.indexOf('>') < 0) continue;
				
				var segments = StrTools.splitTrim(line, '>');
				var startPath = segments[0];
				var endPath = segments[1];
				try 
				{
					execute(startPath, endPath);					
				} catch (err:Dynamic)
				{
					Sys.println('- ERROR: Could not perform file copy execute');
				}
			}
		} 
		catch (err:Eof) { }
		Sys.println('File copying done!');
		Sys.println('--------------------------------------------------');
	}
	
	static public function execute(startPath:String, endPath:String) 
	{
		if (!FileTools.exists(startPath)) 
		{
			Sys.println('- ERROR: File $startPath doesn\'t exist');
			return;
		}
		
		var endExtension:String = Path.extension(endPath);
		if (endExtension.length > 0) 
		{
			Sys.println('- ERROR: The endPath $endPath does not seem to be a directory');
			return;
		}
		
		if (! FileSystem.isDirectory(endPath))
		{
			Sys.println('- ERROR: The endPath $endPath does not seem to be a directory');
			return;			
		}
		
		var startFilename = Path.withoutDirectory(startPath);
		var endPath = Path.addTrailingSlash(endPath) + startFilename;
		try 
		{
			File.copy(startPath, endPath);
			Sys.println('* SUCCESS: File $startPath copied to $endPath');
		} catch (err:Dynamic)
		{
			Sys.println('- ERROR: Could not coyp file $startPath to $endPath - $err');
		}
		
	}
	
}
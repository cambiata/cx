package cx;
import haxe.Serializer;
import haxe.Timer;
import haxe.Unserializer;
import neko.FileSystem;

/**
 * ...
 * @author Jonas Nyström
 */

using StringTools;
class CacheTools 
{
	
	static public var cacheDir:String = Web.getCwd() + 'cache/';	
	
	static public function getContent(cachefilename:String, maxAgeSeconds:Int=10, contentCallback:Void -> String = null):String {				
		var fullfilename = getFullFilename(cachefilename);
		removeCacheFileIfToOld(fullfilename, maxAgeSeconds);		
		var content:String;
		if (FileSystem.exists(fullfilename)) {			
			content = FileTools.getContent(fullfilename);
		} else {			
			if (contentCallback != null) {
				content = contentCallback();
			} else {
				content = FileTools.getContent(cachefilename);
			}			
			FileTools.putContent(fullfilename, content);			
		}
		return content;
	}
	
	static public function getObject(cachefilename:String, maxAgeSeconds:Int = 10, contentCallback:Void -> Dynamic = null):Dynamic {
		var fullfilename = getFullFilename(cachefilename);
		removeCacheFileIfToOld(fullfilename, maxAgeSeconds);		
		var content:Dynamic;
		if (FileSystem.exists(fullfilename)) {			
			content = Unserializer.run(FileTools.getContent(fullfilename));
		} else {			
			if (contentCallback != null) {
				content = contentCallback();
			} else {
				content = Unserializer.run(FileTools.getContent(cachefilename));
			}			
			FileTools.putContent(fullfilename, Serializer.run(content));			
		}
		return content;		
	}

	static public function getFileAgeSeconds(filename:String):Int {
		return FileTools.getFileAgeSeconds(filename);
	}

	static public function removeCacheFileIfToOld(filename:String, ageSeconds:Int) {
		if (FileSystem.exists(filename)) {
			var age = getFileAgeSeconds(filename);
			//trace(age);
			if (age > ageSeconds) {
				//trace('delete!');
				FileSystem.deleteFile(filename);
			}
		}		
	}
	
	static private function getFullFilename(filename:String):String {
		return cacheDir + filename.replace('/', '_').replace('\\', '_') + '.cache';		
	}	
}
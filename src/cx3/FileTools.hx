package cx3;
import sys.io.File;

/**
 * ...
 * @author Jonas Nyström
 */
class FileTools
{

	static public function getContent(filename:String):String {
		return File.getContent(filename);
	}
	
	static public function putContent(filename:String, content:String) {
		var f = File.write(filename, false);
		f.writeString(content);
		f.close();		
	}	
	
}
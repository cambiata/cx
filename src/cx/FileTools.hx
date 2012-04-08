package cx;
/**
 * ...
 * @author Jonas Nyström
 */

class FileTools
{

	static public function test() {
		return 'test';
	}

	
	static public function putContent(filename:String, content:String) {
		var f = neko.io.File.write(filename, false);
		f.writeString(content);
		f.close();		
	}

	static public function putContentBinary(filename:String, content:String) {
		var f = neko.io.File.write(filename, true);
		f.writeString(content);
		f.close();		
	}
	
	static public function filesNamesInDirectory(dir:String) {
		var filenames = neko.FileSystem.readDirectory(dir);
		filenames.sort(function(a, b) return Reflect.compare(a.toLowerCase(), b.toLowerCase()) );		
		return filenames;
	}
	
	static public function filesBytesInDirectory(dir:String):List<haxe.io.Bytes> {
		var bytesList = new List<haxe.io.Bytes>();
		var filenames = filesNamesInDirectory(dir);
		for (filename in filenames) { bytesList.add(neko.io.File.getBytes(dir + filename)); }		
		return bytesList;
	}	
	

}
package cx;
import haxe.io.BytesData;
import neko.FileSystem;
import neko.io.File;
import haxe.io.Bytes;
import neko.Sys;

using StringTools;
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

	static public function getContent(filename:String):String {
		return File.getContent(filename);
	}
	
	/*
	static public function putContentBinary(filename:String, content:String) {
		var f = neko.io.File.write(filename, true);
		f.writeString(content);
		f.close();		
	}
	*/
	
	static public function getFilesNamesInDirectory(dir:String, ?ext=''):Array<String> {
		var filenames = neko.FileSystem.readDirectory(dir);
		
		var validFilenames = new Array<String>();		
		if (ext != '') {
			for (filename in filenames) {
				if (StringTools.endsWith(filename, ext)) validFilenames.push(filename);
			}
			filenames = validFilenames;
		}
		
		filenames.sort(function(a, b) return Reflect.compare(a.toLowerCase(), b.toLowerCase()) );		
		return filenames;
	}
	
	static public function getDirectories(dir:String, includeFiles:Bool=false, dirs:Array<String>=null) {
		var items = neko.FileSystem.readDirectory(dir);
		for (item in items) {
			var testdir = dir + '/' + item;
			if (FileSystem.isDirectory(testdir)) {
				if (dirs == null) dirs = new Array<String>();
				dirs.push(testdir);
				getDirectories(testdir, includeFiles, dirs);
			} else {
				if (includeFiles) {
					dirs.push(testdir);
				}
			}
		}
		return dirs;
	}
	
	static public function getFilesInDirectories(dir:String, ?ext = '', ?recursive = true, dirs:Array<String> = null) {
		if (dirs == null) dirs = new Array<String>();
		var items = neko.FileSystem.readDirectory(dir);
		for (item in items) {
			var testdir = dir + '/' + item;
			if (FileSystem.isDirectory(testdir)) {				
				//dirs.push(testdir);
				getFilesInDirectories(testdir, ext, recursive, dirs);
			} else {				
				if (ext != '') {
				if (StringTools.endsWith(testdir, ext)) dirs.push(testdir);
				} else dirs.push(testdir);
			}
		}
		return dirs;
	}
	
	/*
	static public function filesBytesInDirectory(dir:String):List<haxe.io.Bytes> {
		var bytesList = new List<haxe.io.Bytes>();
		var filenames = filesNamesInDirectory(dir);
		for (filename in filenames) { bytesList.add(neko.io.File.getBytes(dir + filename)); }		
		return bytesList;
	}	
	*/
	
	static public function getFileDataBytesInDirectory(dir:String, ?ext=''):List<BytesData> {
		var list = new List<BytesData>();		
		dir = StringTools.replace(dir, '\\', '/');
		if (!StringTools.endsWith(dir, '/')) dir = dir + '/';
		var filenames = getFilesNamesInDirectory(dir, ext);
		
		for (filename in filenames) { 
			
			var bytes = File.getBytes(dir + filename);
			
			var bytesData:BytesData = BytesData.ofString(bytes.toString());
			list.add(bytesData);
		}
		return list;
	}
	
	static public function getBytes(filename:String): Bytes {		
		return File.getBytes(filename);		
	}
	
	static public function putBytes(filename:String, bytes:Bytes) {
		var f = neko.io.File.write(filename, true);
		f.write(bytes);
		f.close();		
	}
	
	static public function putBinaryContent(filename:String, content:String) {
		var f = neko.io.File.write('test.png', true);
		f.writeString(content);
		f.close();			
	}
	
	
	
	static public function executeFile(filename:String) {
	
		if (!neko.FileSystem.exists(filename)) throw "Can't find file: " + filename;
		var command:String;
		command = '"' + Sys.getCwd() + filename + '"';
		command = command.replace("/", "\\");
		//trace(command);
		if (!FileSystem.exists(command)) {
			command = '"' + FileSystem.fullPath(filename) + '"';
			command = command.replace("/", "\\");
		}				
		Sys.command(command);
	}

	static public function putContentExecute(filename:String, content:String) {
		putContent(filename, content);
		executeFile(filename);
	}
	
	static public function putBinaryContentExecute(filename:String, content:String) {
		putBinaryContent(filename, content);
		executeFile(filename);
	}
	
	static public function stripPath(filename:String):String {
		filename = StringTools.replace(filename, '\\', '/');
		return filename.substr(filename.lastIndexOf('/')+1);		
	}
	
	static public function getFirstFilenameSegment(filename:String):String {
		filename = stripPath(filename);
		var segments = filename.split('.');
		return return segments[0];
	}
	

}
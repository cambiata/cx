package cx;
import haxe.io.BytesData;
import haxe.io.Eof;
//import neko.FileSystem;
//import neko.io.File;
import haxe.io.Bytes;
//import neko.Sys;

#if (neko||cpp) 
import sys.FileSystem;
import sys.io.File;
#end

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
	
	static public function deleteFile(path:String) {
		try {
			FileSystem.deleteFile(path);
		} catch (e:Dynamic) { throw "Can't delete file " + path; }
	}
	
	static public function deleteDirectory(dir:String) {
		deleteFilesInDirectory(dir);
		try {
			FileSystem.deleteDirectory(dir);
		} catch (e:Dynamic) { throw "Can't delete directory " + dir; }
	}
	
	static public function deleteFilesInDirectory(dir:String) {
		if (!FileSystem.exists(dir)) throw "Directory doesnt exist!";
		var files = FileTools.getFilesInDirectories(dir);
		for (file in files) {
			try {
				deleteFile(file);
			} catch (e:Dynamic) { throw "Can't delete file " + file; }
		}	
	}

	static public function createDirectory(dir:String) {
		if (FileSystem.exists(dir)) return;
		FileSystem.createDirectory(dir);
	}
	
	static public function exists(path:String) {
		
		return FileSystem.exists(path);
	}
	
	static public function safeSlashes(path:String, endSlash:Bool=false):String {
		path = StringTools.replace(path, '\\', '/');
		if (endSlash) path = (StringTools.endsWith(path, '/')) ? path : path + '/';
		return path;
	}
	
	static public function putContent(filename:String, content:String) {
		var f = File.write(filename, false);
		f.writeString(content);
		f.close();		
	}

	static public function getContent(filename:String):String {
		return File.getContent(filename);
	}
	
	
	
	static public function getFilesNamesInDirectory(dir:String, ?ext='', startsWith=''):Array<String> {
		var filenames = FileSystem.readDirectory(dir);
		
		if (ext != '') {
			var validFilenames = new Array<String>();
			for (filename in filenames) {
				if (StringTools.endsWith(filename, ext)) validFilenames.push(filename);
			}
			filenames = validFilenames;
		}

		if (startsWith != '') {
			var validFilenames = new Array<String>();
			for (filename in filenames) {
				if (StringTools.startsWith(filename, startsWith)) validFilenames.push(filename);
			}
			filenames = validFilenames;
		}
		
		filenames.sort(function(a, b) return Reflect.compare(a.toLowerCase(), b.toLowerCase()) );		
		return filenames;
	}
	
	static public function getDirectories(dir:String, includeFiles:Bool=false, dirs:Array<String>=null, giveDirsExt:String='') {
		var items = FileSystem.readDirectory(dir);
		for (item in items) {
			var testdir = dir + '/' + item;			
			if (FileSystem.isDirectory(testdir)) {
				if (dirs == null) dirs = new Array<String>();
				
				var dirname = (giveDirsExt != '') ? testdir + giveDirsExt: testdir;
				dirs.push(dirname);
				
				getDirectories(testdir, includeFiles, dirs, giveDirsExt);
			} else {
				if (includeFiles) {
					if (dirs == null) dirs = new Array<String>();
					dirs.push(testdir);
				}
			}
		}
		return dirs;
	}
	
	static public function getFilesInDirectories(dir:String, ?ext = '', ?recursive = true, dirs:Array<String> = null) {
		if (dirs == null) dirs = new Array<String>();
		var items = FileSystem.readDirectory(dir);
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
	
	/*
	static public function getFileDataBytesInDirectory(dir:String, ?ext=''):List<BytesData> {
		var list = new List<BytesData>();		
		dir = safeSlashes(dir);
		var filenames = getFilesNamesInDirectory(dir, ext);
		
		for (filename in filenames) { 
			
			var bytes = File.getBytes(dir + filename);
			
			var bytesData:BytesData = BytesData.ofString(bytes.toString());
			list.add(bytesData);
		}
		return list;
	}
	
	static public function getFileBytesInDirectory(dir:String, ?ext=''):List<Bytes> {
		var list = new List<Bytes>();		
		dir = safeSlashes(dir);
		var filenames = getFilesNamesInDirectory(dir, ext);		
		for (filename in filenames) { 			
			var bytes = File.getBytes(dir + filename);			
			//var bytesData:BytesData = BytesData.ofString(bytes.toString());
			//list.add(bytesData);
			list.add(bytes);
		}
		return list;
	}
	*/
	
	static public function getBytes(filename:String): Bytes {		
		return File.getBytes(filename);		
	}
	
	static public function putBytes(filename:String, bytes:Bytes) {
		var f = File.write(filename, true);
		f.write(bytes);
		f.close();		
	}
	
	static public function putBinaryContent(filename:String, content:String) {
		var f = File.write(filename, true);
		f.writeString(content);
		f.close();			
	}
	
	static public function executeFile(filename:String) {	
		if (!FileSystem.exists(filename)) throw "Can't find file: " + filename;
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
	
	static public function stripLastSlash(path:String) {
		if (path.endsWith('/')) path = path.substr(0, path.length-1);
		if (path.endsWith('\\')) path = path.substr(0, path.length-1);
		return path;
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

	static public function getFileAgeSeconds(filename:String):Null<Int> {
		if (FileSystem.exists(filename)) {
			var stat = FileSystem.stat(filename);
			var a = stat.atime;
			return Std.int((Date.now().getTime() - stat.atime.getTime())/1000);
		}		
		return null;
	}

	static public function getDirectory(fullfilename:String, slash='/') {
		return Tools.stringBeforeIncludingLast(FileTools.safeSlashes(fullfilename), slash);
	}
	
	static public function getFilename(fullfilename:String, includeExt:Bool = true) {
		var filename = StrTools.afterLast(FileTools.safeSlashes(fullfilename), '/');		
		if (! includeExt) filename = PathTools.excludeExtension(filename);
		return filename;
	}
	
	static public function getArrayFromItemsFile(filename:String) {		
		var ret = new Array<String>();
		var file = File.read(filename, false);		
		try {
			while(true) {
				var line = file.readLine().trim();
				ret.push(line);
			}
		} catch(e : Eof){}			
		
		return ret;
	}
	
	static public function getExtension(filename:String) {
		return PathTools.getExtension(filename); // filename.substr(filename.lastIndexOf('.') + 1);
	}
	
	static public function excludeExtension(filename:String) {
		return PathTools.excludeExtension(filename);
	}
	
	static public function rename(path:String, newpath:String) {
		FileSystem.rename(path, newpath);
	}
	
	static public function correctPath(path:String, endSlash = false, slash='/') {
		path = path.replace('\\', slash);
		
		if (endSlash) {
			if (! path.endsWith(slash)) path += slash;
		} else {
			if (path.endsWith(slash)) path = path.substr(0, path.length-1);			
		}
		
		path = path.replace('//', '/');
		return path;
	}
	
	static public function backup(filename:String, backupDir = '', generations = 2) {		
		filename = correctPath(filename);
		generations--;				
		var directory = getDirectory(filename);
		var filename = getFilename(filename);
		var backupDir = (backupDir != '') ? correctPath(backupDir, true) : '';
		
		while (generations > 0) {
			var testfilename = directory + backupDir + filename + '.backup' + generations;
			var newfilename = directory + backupDir + filename + '.backup' + (generations+1);
			if (exists(testfilename)) {
				//trace([testfilename, newfilename]);
				rename(testfilename, newfilename);
			}
			generations--;
		}		
		
		var testfilename = directory + filename;
		var newfilename = directory + backupDir + filename + '.backup1';
		//trace(testfilename);
		if (exists(testfilename)) {
			//trace([testfilename, newfilename]);
			rename(testfilename, newfilename);				
		}
	}
	
}
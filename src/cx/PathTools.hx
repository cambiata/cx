package cx;

/**
 * ...
 * @author Jonas Nyström
 */
using StringTools;
class PathTools 
{
	static public function addSlash(path:String, slash='/') {
		if (! path.endsWith(slash)) return path + slash;
		return path;
	}

	static public function addSlashBefore(path:String, slash = "/") {
		if (! path.startsWith(slash)) return slash + path;
		return path;
	}
	
	static public function removeSlash(path:String, slash = "/") {
		while ( path.endsWith(slash)) path = path.substr(0, -1);
		return path;
	}
	
	static public function removeSlashBefore(path:String, slash = '/') {
		while ( path.startsWith(slash)) path = path.substr(1);
		return path;
	}
	
	static public function firstSegment(path:String, slash = '/'):String {
		return path.split(slash).shift();		
	}
	
	static public function lastSegment(path:String, slash = '/'):String {
		return path.split(slash).pop();
	}
	
	static public function getExtension(filename:String) {
		if (filename.indexOf('.') == -1) return '';
		return filename.substr(filename.lastIndexOf('.')+1);
	}	
	
	static public function excludeExtension(filename:String) {
		var ext = PathTools.getExtension(filename);
		if (ext.length == 0) return filename;
		if (filename.endsWith(ext)) return filename.substr(0, filename.length - ext.length - 1);
		return '';
	}	
	
	static public function addHttp(path:String, http = 'http://') {
		if (! path.startsWith(http)) return http + path;
		return path;
	}

	static public function getUpperLevel(path:String):String
	{	
		path = removeSlash(path);
		path = StrTools.untilLast(path, '/');		
		if (path == '') path = '/';
		return path;
	}	
	
	
}
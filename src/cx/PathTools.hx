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
	
}
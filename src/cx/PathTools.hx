package cx;

/**
 * ...
 * @author Jonas Nyström
 */
using StringTools;
class PathTools 
{
	static public function addSlash(path:String, slash='/') {
		if (! path.endsWith(slash)) path += slash;
		return path;
	}

	
}
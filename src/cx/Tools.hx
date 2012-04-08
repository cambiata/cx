package cx;

/**
 * ...
 * @author Jonas Nyström
 */

class Tools 
{
	static public function stringRepeater(count:Int, repString:String) {
		var r = '';
		for (i in 0...count) {
			r += repString;
		}
		return r;
	}
	
}
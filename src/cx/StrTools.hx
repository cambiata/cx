package cx;

/**
 * ...
 * @author Jonas Nyström
 */

class StrTools 
{

	static public function stringRepeater(repString:String, count:Int) {
		var result = '';
		for (i in 0...count) result += repString;
		return result;
	}
	
	static public function fillString(str:String, toLength:Int = 32, ?with :String = ' ', ?replaceNull:String='-') {
		if (str == null) str = replaceNull;
		do { str += with; } while (str.length < toLength);
		return str.substr(0, toLength);
	}	
	
	static public function splitTrim(str:String, delimiter:String=','):Array<String> {
		var a = str.split(delimiter);
		var a2 = Lambda.array(Lambda.map(a, function(item) { return StringTools.trim(item); } ));
		return a2;
	}	
	
	static public function replaceNull(str:String, with:String = '-'):String {
		return (str == null) ? with : str;
	}	
	
}
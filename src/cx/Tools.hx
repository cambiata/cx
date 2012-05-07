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
	
	static public function splitTrim(str:String, delimiter:String=','):Array<String> {
		var a = str.split(delimiter);
		var a2 = Lambda.array(Lambda.map(a, function(item) { return StringTools.trim(item); } ));
		return a2;
	}
	
	static public function toInt(float:Float):Int {
		return Std.int(float);
	}
	
	static public function fillString(str:String, toLength:Int = 32, ?with :String = ' ', ?replaceNull:String='-') {
		if (str == null) str = replaceNull;
		do { str += with; } while (str.length < toLength);
		return str.substr(0, toLength);
	}
	
	static public function stringAscii(str:String):String {
		str = StringTools.replace(str, 'å', String.fromCharCode(0xe5));
		str = StringTools.replace(str, 'ä', String.fromCharCode(0xe4));
		str = StringTools.replace(str, 'ö', String.fromCharCode(0xf6));
		str = StringTools.replace(str, 'Å', String.fromCharCode(0xc5));
		str = StringTools.replace(str, 'Ä', String.fromCharCode(0xc4));
		str = StringTools.replace(str, 'Ö', String.fromCharCode(0xd6));
		str = StringTools.replace(str, 'é', String.fromCharCode(0xe9));
		str = StringTools.replace(str, 'è', String.fromCharCode(0xe8));		
		return str;
	}
	
	#if neko 
	static public function getComputername():String return neko.Sys.getEnv('COMPUTERNAME')
	#end
	
	static public function inRange(min:Float, value:Float, max:Float):Bool {
		if (value < min) return false;
		if (value > max) return false;
		return true;
	}
	
	static public function intRange(min:Int, value:Int, max:Int):Int {
		if (value < min) return min;
		if (value > max) return max;
		return value;
	}	
	
	static public function floatRange(min:Float, value:Float, max:Float):Float {
		if (value < min) return min;
		if (value > max) return max;
		return value;
	}		
	
	
	
	
	static public function arraysOverlap(array1:Array<Dynamic>, array2:Array<Dynamic>):Bool {		
		for (item1 in array1) {
			if (Lambda.has(array2, item1) == true) return true;
		}
		return false;
	}
	
	static public function replaceNullString(str:String, with :String = '-'):String {
		if (str == null) return with ;
		return str;
	}
	
	
	
	
}


package cx;

import haxe.Int32;
import tea.TEA;

/**
 * ...
 * @author Jonas Nyström
 */

class CryptTools 
{

	static public function teaCrypt(str:String):String {		
		var key = Std.string(Math.random() % Date.now().getTime()).substr(2, 4);
		var keyLeft = key.substr(0, 2);
		var keyRight = key.substr(2, 2);
		setTeaKey(Std.parseInt(key));
		return keyLeft + TEA.crypt(str) + keyRight;
	}
	
	static public function teaUncrypt(str:String):String {
		var keyLeft = str.substr(0, 2);
		var keyRight = str.substr(str.length - 2, 2);
		var key = keyLeft + keyRight;		
		var str = str.substr(2,  str.length - 4);
		setTeaKey(Std.parseInt(key));
		return TEA.uncrypt(str);
	}
	
	static private function setTeaKey(keyInt:Int) {
		var keyInt = Int32.ofInt(keyInt);
		TEA.key = [Int32.ofInt(1), Int32.ofInt(2), Int32.ofInt(3), keyInt];
	}
	
}
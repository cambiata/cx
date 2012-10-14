package cx;

import haxe.Int32;
import tea.TEA;

/**
 * ...
 * 
 * @author Jonas Nyström
 */

using cx.StrTools;
class CryptTools 
{

	static public function crypt(str:String):String {		
		var key = Std.string(Math.random() % Date.now().getTime()).substr(2, 4);
		var keyLeft = StrTools.numToStr(key.substr(0, 2), 97);		
		var keyRight = StrTools.numToStr(key.substr(2, 2), 97);
		setTeaKey(Std.parseInt(key));
		return keyLeft + TEA.crypt(str) + keyRight;
	}
	
	static public function decrypt(str:String):String {
		var keyLeft = StrTools.strToNum(str.substr(0, 2), 97);
		var keyRight = StrTools.strToNum(str.substr(str.length - 2, 2), 97);
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
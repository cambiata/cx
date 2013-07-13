package karin.tools;

/**
 * ...
 * @author Jonas Nyström
 */
using cx3.StrTools;
class UserTools
{
	static public function peronnrToId(personnr:String):String {		
		var rotateNr = Std.parseInt(personnr.substr( -1));
		var rotateChar = StrTools.intToChar(rotateNr);
		//trace(rotateNr);
		//trace(rotateChar);		
		var id = personnr;		
		id = personnr.split('-').join('');
		//trace(id);		
		var s1 = id.substr(0, 4);
		var s2 = id.substr(4, 4);
		var s3 = id.substr(8, 4);
		//trace([s1, s2, s3]);
		s1 = s1.reverse();
		//s2 = s2.reverse();
		s3 = s3.reverse();
		//trace([s1, s2, s3]);
		s1 = intsToChars(s1, 65);		
		s2 = intsToChars(s2, 66);
		s3 = intsToChars(s3, 67);
		//trace([s1, s2, s3]);
		//-------------------------------------------------------
		
		//var randomLast = RandomTools.int(0, 9).intToChar(65);		
		var result = StrTools.rotate(s3 + s2 + s1, rotateNr) + rotateChar /*+ randomLast*/;
		return result;
	}
	
	static public function personidToNr(id:String):String {
		id = id.substr(0, 13);
		var rotateChar = id.substr(-1); // StrTools.intToChar(rotateNr);
		var rotateNr = StrTools.charToInt(rotateChar);
		//trace(rotateChar);		
		//trace(rotateNr);
		id = StrTools.rotateBack(id.substr(0, id.length - 1), rotateNr);
		
		
		var s1 = id.substr(0, 4);
		var s2 = id.substr(4, 4);
		var s3 = id.substr(8, 4);
		
		s1 = charsToInts(s1, 67);
		s2 = charsToInts(s2, 66);
		s3 = charsToInts(s3, 65);
		
		s1 = s1.reverse();
		//s2 = s2.reverse();
		s3 = s3.reverse();
		
		//-------------------------------------------------------
		
		var result = s3 + s2 + '-' + s1;
		return result;
	}
	
	static public function  intsToChars(ints:String, offset=65):String {
		var result = '';
		for (i in 0...ints.length) {
			var int:Int = Std.parseInt(ints.charAt(i)) ;
			var char = StrTools.intToChar(int, offset+(i*2));
			result = result + char;
		}
		return result;
	}
	
	static public function charsToInts(chars:String, offset=65):String {
		var result = '';
		for (i in 0...chars.length) {
			var char:String = chars.charAt(i); 
			var int = StrTools.charToInt(char, offset+(i*2)) ;
			
			var intChar = Std.string(int);
			result = result + intChar;
		}		
		return result;
	}
	

}
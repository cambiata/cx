package ka.tools;

/**
 * ...
 * @author Jonas Nyström
 */
using cx.StrTools;
class UserTools 
{

	
	static public function ssnrToCode(ssnr:String):String {
		
		var rotateNr = Std.parseInt(ssnr.substr( -1));
		var rotateChar = StrTools.intToChar(rotateNr);
		//trace(rotateNr);
		//trace(rotateChar);
		
		var code = ssnr;		
		code = ssnr.split('-').join('');
		
		
		var s1 = code.substr(0, 4);
		var s2 = code.substr(4, 4);
		var s3 = code.substr(8, 4);
		
		s1 = s1.reverse();
		s2 = s2.reverse();
		s3 = s3.reverse();
		
		s1 = intsToChars(s1);
		s2 = intsToChars(s2);
		s3 = intsToChars(s3);
		//-------------------------------------------------------

		var result = StrTools.rotate(s3 + s2 + s1, rotateNr) + rotateChar;
		return result;
	}
	
	static public function codeToSsnr(code:String):String {
		
		var rotateChar = code.substr(-1); // StrTools.intToChar(rotateNr);
		var rotateNr = StrTools.charToInt(rotateChar);
		//trace(rotateChar);		
		//trace(rotateNr);
		
		code = StrTools.rotateBack(code.substr(0, code.length - 1), rotateNr);
		
		
		var s1 = code.substr(0, 4);
		var s2 = code.substr(4, 4);
		var s3 = code.substr(8, 4);
		
		s1 = charsToInts(s1);
		s2 = charsToInts(s2);
		s3 = charsToInts(s3);
		
		s1 = s1.reverse();
		s2 = s2.reverse();
		s3 = s3.reverse();
		
		//-------------------------------------------------------
		
		var result = s3 + s2 + '-' + s1;
		return result;
	}
	

	
	static private function  intsToChars(ints:String):String {
		var result = '';
		for (i in 0...ints.length) {
			var int:Int = Std.parseInt(ints.charAt(i));
			var char = StrTools.intToChar(int, i);
			//trace([int, char]);			
			result = result + char;
		}
		return result;
	}
	
	static private function charsToInts(chars:String):String {
		var result = '';
		for (i in 0...chars.length) {
			var char:String = chars.charAt(i); 
			var int = StrTools.charToInt(char, i);
			var intChar = Std.string(int);
			result = result + intChar;
		}
		
		return result;
	}
	
	
}
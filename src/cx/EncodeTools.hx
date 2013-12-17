package cx;
import haxe.crypto.BaseCode;

import haxe.Utf8;

/**
 * ...
 * @author Jonas Nyström
 */
using StringTools;

class EncodeTools {
	
	static var BASE64SEED = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
	
	static public function base64Encode(str:String) {
		return BaseCode.encode(str, BASE64SEED);		
	}
	
	static public function base64Decode(encodedStr:String) {
		return BaseCode.decode(encodedStr, BASE64SEED);
	}
	
	
	static public function cliDecode(str:String):String {
		if (str == null) return null;
		if (!Utf8.validate(str)) throw 'Error: string ' + str + ' must be Utf8 encoded!';
		
		var r:String = '';		
		var ii = 0;
		
		for (i in 0...Utf8.length(str)) {
			var cc = Utf8.charCodeAt(str, i);
			var ccc = Utf8.sub(str, i, 1);
			var c = str.charAt(i);
			switch(cc) {
				case 229: { r += String.fromCharCode(134); ii += 2;	}
				case 228: { r += String.fromCharCode(132); ii += 2;	}
				case 246: { r += String.fromCharCode(148); ii += 2;	}
				case 197: { r += String.fromCharCode(143); ii += 2;	}
				case 196: { r += String.fromCharCode(142); ii += 2;	}
				case 214: { r += String.fromCharCode(153); ii += 2;	}				
				
				case 224: { r += String.fromCharCode(160); ii += 2;	} 
				case 225: { r += String.fromCharCode(133); ii += 2;	}
				case 193: { r += String.fromCharCode(181); ii += 2;	}
				case 192: { r += String.fromCharCode(183); ii += 2;	}
				
				case 243: { r += String.fromCharCode(162); ii += 2;	} 
				case 242: { r += String.fromCharCode(149); ii += 2;	}
				case 211: { r += String.fromCharCode(224); ii += 2;	}
				case 210: { r += String.fromCharCode(227); ii += 2;	}
				
				case 233: { r += String.fromCharCode(130); ii += 2;	} 
				case 232: { r += String.fromCharCode(138); ii += 2;	}
				case 201: { r += String.fromCharCode(144); ii += 2;	}
				case 200: { r += String.fromCharCode(212); ii += 2;	}

				case 252: { r += String.fromCharCode(129); ii += 2;	}
				case 220: { r += String.fromCharCode(154); ii += 2;	}
				
				default: r += str.charAt(ii++);
			}
		}
		
		return r;
	}
	
	static public function cliEncode(str:String):String {
		if (Utf8.validate(str)) str = Utf8.decode(str);
		
		//throw 'Error: string ' + str + ' must NOT be Utf8 encoded!';
		var r:String = Utf8.encode('');
		for (i in 0...str.length) {
			
			var cc = str.charCodeAt(i);
			var c = str.charAt(i);
			
			switch(cc) {
				
				case 134: r += 'å';
				case 132: r += 'ä';
				case 148: r += 'ö';
				case 143: r += 'Å';
				case 142: r += 'Ä';
				case 153: r += 'Ö';
				
				case 160: r += 'á';
				case 133: r += 'à';
				case 181: r += 'Á';
				case 183: r += 'À';
				
				case 162: r += 'ó';
				case 149: r += 'ò';
				case 224: r += 'Ó';
				case 227: r += 'Ò';				
				
				
				case 130: r += 'é';
				case 138: r += 'è';
				case 144: r += 'É';
				case 212: r += 'È';				
				
				case 129: r += 'ü';
				case 154: r += 'U';
				
				
				default: r += c;
			}			
		}
		return r;
	}		
	
	static public function pathsafe(str:String):String {
		if (Utf8.validate(str)) str = Utf8.decode(str);
		str = str.toLowerCase();
		str = str.replace(' ', '-').replace('--', '-');
		
		var r:String = Utf8.encode('');
		for (i in 0...str.length) {
			
			var cc = str.charCodeAt(i);
			var c = str.charAt(i);
			
			switch(cc) {				
				case 228: r += 'a'; // å
				case 229: r += 'a'; // ä
				case 246: r += 'o'; // ö
				
				default: r += c;
			}			
		}
		return r;		
	}
	
}
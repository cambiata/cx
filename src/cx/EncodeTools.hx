package cx;
import haxe.BaseCode;

/**
 * ...
 * @author Jonas Nyström
 */


class EncodeTools {
	
	static var BASE64SEED = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
	
	static public function base64Encode(str:String) {
		return haxe.BaseCode.encode(str, BASE64SEED);		
	}
	
	static public function base64Decode(encodedStr:String) {
		return BaseCode.decode(encodedStr, BASE64SEED);
	}
	
	
}
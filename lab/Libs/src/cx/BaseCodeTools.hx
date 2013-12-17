package cx;
import haxe.crypto.BaseCode;

/**
 * ...
 * @author 
 */
class BaseCodeTools
{
	static public var base = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ=.";

	public static function encode(string:String):String
	{
		return BaseCode.encode(string, base);
	}

	public static function decode(string:String):String
	{
		return BaseCode.decode(string, base);
	}
}
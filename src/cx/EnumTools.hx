package cx;

/**
 * ...
 * @author Jonas Nyström
 */
using StringTools;
class EnumTools 
{
	static public function createFromString<T>(e:Enum<T>, str:String): T {		
		try {
			var type = str;
			var params:Array<String> = [];
			if (StrTools.has(str, '(')) {
				var parIdx = str.indexOf('(');
				type = str.substr(0, parIdx);
				params = str.substr(parIdx).replace('(', '').replace(')', '').split(',');
			}
			return Type.createEnum(e, type, params);	
		} catch(e:Dynamic) {}
		return null;
	}
	

	
}
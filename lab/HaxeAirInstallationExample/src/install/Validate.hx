package install;

/**
 * ...
 * @author 
 */
class Validate
{

	
	static public function string(str:String):String
	{
		return (str == null || str.length < 1 || str.indexOf("<") >= 0 || str.indexOf(">") >= 0) ? null : str;
	}

	public static var VALID_PROTOCOLS:Array<String> = ["http","https"];
	static public function URL(url:String):String {
		if (url == null) { return null; }
		
		
		
		/*
		var markerIndex:Int = url.search(/:|%3a/i);
		if (markerIndex > 0) {
			var scheme:String = url.substr(0, markerIndex).toLowerCase();
			if (VALID_PROTOCOLS.indexOf(scheme) == -1) { return null; }
		}
		*/
		
		if (url.indexOf("<") >= 0 || url.indexOf(">") >= 0) {
			return null;
		}
		return url;
	}	
	
	public static  function params(params):Bool {
		return !(params.appName == null || params.appURL == null || params.airVersion == null);
	}	
	
}
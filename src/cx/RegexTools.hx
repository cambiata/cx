package cx;

/**
 * ...
 * @author Jonas Nyström
 */

class RegexTools 
{

	static public function closeImageTags(htmlString:String) {
		var r = ~/(<img)(\/?[^>]+)(>)/gim; 
		return r.replace(htmlString, "$1$2/>");		
	}
	
	static public function closeHrTags(htmlString:String) {
		var r = ~/(<hr)(\/?[^>]+)(>)/gim; 
		return r.replace(htmlString, "$1$2/>");		
	}	
	
}
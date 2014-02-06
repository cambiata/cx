package cx;

/**
 * ...
 * @author Jonas Nyström
 */

class RegexTools 
{

	static public function closeImageTags(htmlString:String) 
	{
		var r = ~/(<img)([^>]*)(>)/gim; 
		return r.replace(htmlString, "$1$2/>");		
	}
	
	static public function closeHrTags(htmlString:String) 
	{
		var r = ~/(<hr)([^>]*)(>)/gim; 
		return r.replace(htmlString, "$1$2/>");		
	}
	
	static public function hasNumber(string:String) :Bool 
	{
		var r = ~/[0-9]+/gim; 				
		return r.match(string);		
	}
	
	static public function hasSwedishNameChars(string:String) :Bool 
	{		
		var r = ~/[^a-zA-ZåäöÅÄÖéÉèÈüÜóòáà -]+/; 				
		return !r.match(string);
	}
	
	static public function getMatchedArray(r:EReg):Array<Dynamic> 
	{
		var a = new Array<Dynamic>();
		for (i in 1...5) {
			try {
				var s = r.matched(i);
				//trace(s);
				a.push(s);
			} catch (e:Dynamic) {
				return a;
			}
		}
		return a;
	}
	
}
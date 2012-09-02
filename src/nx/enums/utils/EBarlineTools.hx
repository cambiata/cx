package nx.enums.utils;
import nx.enums.EBarline;

/**
 * ...
 * @author Jonas Nyström
 */

class EBarlineTools
{

	static public function nextBarline(barline:EBarline): EBarline {
		var result:EBarline = EBarline.Normal;
		if (barline == null) return result;
		
		switch (barline) {
			case EBarline.Normal: result = EBarline.Double;
			case EBarline.Double: result = EBarline.Final;
			default:
		}
		return result;
	}
	
}
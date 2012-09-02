package nx.enums.utils;
import nx.enums.EClef;

/**
 * ...
 * @author Jonas Nyström
 */

class EClefTools 
{

	static public function nextClef(clef:EClef) : EClef {
		if (clef == null) return EClef.ClefG;
		var result:EClef = null;
		switch (clef) {
			case EClef.ClefG: result = EClef.ClefF;
			case EClef.ClefF: result = EClef.ClefC;
			case EClef.ClefC: result = null;
			default: result = EClef.ClefG;
		}
		return result;
	}
	
}
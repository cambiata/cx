package nx.enums.utils;
import nme.geom.Rectangle;
import nx.enums.ESign;

/**
 * ...
 * @author Jonas Nyström
 */

class ESignTools 
{
	
	static public function getSignRect(sign:ESign) :Rectangle {
		switch(sign) {
			case ESign.None: return null;
			case ESign.DoubleFlat: return new Rectangle(0, -2, 4, 2);
			case ESign.DoubleSharp: return new Rectangle(0, -2, 4, 2);
			default: return new Rectangle(0, -2, 3, 2);
		}
		return null;
	}
	
}
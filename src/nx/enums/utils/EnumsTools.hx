package nx.enums.utils;
import nx.enums.EAckolade;
import nx.enums.EBarline;
import nx.enums.EBarlineLeft;
import nx.enums.ETime;

/**
 * ...
 * @author Jonas Nyström
 */

class EnumsTools 
{

	static public function widthBarlineLeft(barlineLeft:EBarlineLeft) : Float {		
		if (barlineLeft == null) return Constants.ATTRIBUTE_NULL_WIDTH;
		switch(barlineLeft) {
			case None: return Constants.ATTRIBUTE_NULL_WIDTH;
			case Single: return 1;
			case Double: return 3;
			case StartRepeat: return 8;
			default: 
				return Constants.ATTRIBUTE_NULL_WIDTH;
		}
		return 0;		
	}
	
	static public function widthBarline(barline:EBarline) : Float {
		if (barline == null) return Constants.ATTRIBUTE_NULL_WIDTH;
		switch (barline) {
			case None: return Constants.ATTRIBUTE_NULL_WIDTH;
			case Normal: return Constants.BARLINE_NORMAL_WIDTH;
			case Double: return Constants.BARLINE_DOUBLE_WIDTH;
			default: return 8;
		}
		return 0;
	}
	
	static public function widthTime(time:ETime):Float {
		if (time == null) return Constants.ATTRIBUTE_NULL_WIDTH;
		return Constants.TIME_WIDTH;
	}
	
	static public function widthAckolade(ack:EAckolade): Float {
		if (ack == null) return Constants.ATTRIBUTE_NULL_WIDTH;
		switch (ack) {
			case EAckolade.None: return Constants.ATTRIBUTE_NULL_WIDTH;
			case EAckolade.Line: return 1;
			case EAckolade.Curly, EAckolade.Bracket: return 8;
			default: return 20;
		}
		return 0;
	}
}
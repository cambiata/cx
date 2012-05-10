package nx.enums;
import nx.Constants;

/**
 * ...
 * @author Jonas Nyström
 */

class ETime {
	static public var T4_4 = new ETime(Constants.BASE_NOTE_VALUE * 4);
	static public var T3_4 = new ETime(Constants.BASE_NOTE_VALUE * 3);
	static public var T2_4 = new ETime(Constants.BASE_NOTE_VALUE * 2);
	
	public function new(value:Int) {
		this.value = value;
	}
	public var value:Int;
	
}
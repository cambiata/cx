package nx.enums;
import haxe.Timer;
import nx.Constants;

/**
 * ...
 * @author Jonas Nyström
 */

class ETime {
	
	static public var T4_4 			= 	new ETime('4/4', Constants.BASE_NOTE_VALUE * 4);
	static public var T3_4 			= 	new ETime('3/4', Constants.BASE_NOTE_VALUE * 3);
	static public var T2_4 			= 	new ETime('2/4', Constants.BASE_NOTE_VALUE * 2);
	
	static public var T3_8 			= 	new ETime('3/8', Std.int(Constants.BASE_NOTE_VALUE * 1.5));
	static public var T6_8 			= 	new ETime('6/8', Constants.BASE_NOTE_VALUE * 3);
	static public var T9_8 			= 	new ETime('9/8', Std.int(Constants.BASE_NOTE_VALUE * 4.5));
	static public var T12_8 		= 	new ETime('12/8', Constants.BASE_NOTE_VALUE * 6);
	
	static public var TCommon 	= 	new ETime('Common', Constants.BASE_NOTE_VALUE * 4);
	static public var TAllabreve 	= 	new ETime('Allabreve', Constants.BASE_NOTE_VALUE * 4);
	
	public function new(id:String, value:Int) {
		this.id = id;
		this.value = value;
	}
	
	public var id:String;
	public var value:Int;
	
	static public function getFromId(id:String): ETime {
		var ret:ETime = null;
		switch (id) {
			case '4/4': ret = ETime.T4_4;
			case '3/4': ret = ETime.T3_4;
			case '2/4': ret = ETime.T2_4;
			case '3/8': ret = ETime.T3_8;
			case '6/8': ret = ETime.T6_8;
			case '9/8': ret = ETime.T9_8;
			case '12/8': ret = ETime.T12_8;	
			
			case 'Common': ret = ETime.TCommon;	
			case 'Allabreve': ret = ETime.TAllabreve;	
			
		}
		return ret;
	}	
}
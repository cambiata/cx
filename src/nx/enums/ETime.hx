package nx.enums;

/**
 * ...
 * @author Jonas Nyström
 */

enum ETime
{
	Time4_4;
	Time3_4;
	Time2_4;
	
	Time3_8;
	Time4_8;
	Time5_8;
	Time6_8;
	Time9_8;
	Time12_8;
	
	TimeCommon;
	TimeAllabreve;
}


class ETimeUtils {
	
	static public function toString(time:ETime):String {
		switch(time) {
			case Time4_4: 	return '4/4';
			case Time3_4:	return '3/4';
			case Time2_4:	return '2/4';
			
			case Time3_8: 	return '3/8';
			case Time4_8: 	return '4/8';
			case Time5_8: 	return '5/8';
			case Time6_8: 	return '6/8';
			case Time9_8: 	return '9/8';
			case Time12_8: 	return '12/8';
			
			case TimeCommon: return 'Common';
			case TimeAllabreve: return 'Allabreve';
		}
		return "time-unknown";
	}

	static public function fromString(str:String):ETime {
		if (str == null) return null;
		switch(str) {
			case '4/4':		return ETime.Time4_4;
			case '3/4':		return ETime.Time3_4;
			case '2/4':		return ETime.Time2_4;
			
			case '3/8':		return ETime.Time3_8;
			case '4/8':		return ETime.Time4_8;
			case '5/8':		return ETime.Time5_8;
			case '6/8':		return ETime.Time6_8;
			case '9/8':		return ETime.Time9_8;
			case '12/8':		return ETime.Time12_8;
			
			case 'Common': return ETime.TimeCommon;
			case 'Allabreve': return ETime.TimeAllabreve;
			default: 			return null;			
		}
		return null;
	}
	
	
}
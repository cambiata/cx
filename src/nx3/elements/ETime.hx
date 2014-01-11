package nx3.elements;

/**
 * ...
 * @author Jonas Nyström
 */
enum ETime
{
	Time2_2;
	Time3_2;
	Time4_2;
	
	Time2_4;
	Time3_4;
	Time4_4;
	Time5_4;
	Time6_4;
	Time7_4;
	
	Time2_8;
	Time3_8;
	Time4_8;
	Time5_8;
	Time6_8;
	Time7_8;
	Time9_8;
	Time12_8;
	
	TimeCommon;
	TimeAllabreve;
}


class ETimeUtils {
	
	static public function toString(time:ETime):String {
		switch(time) {
			case Time2_2: 	return '2/2';
			case Time3_2: 	return '3/2';
			case Time4_2: 	return '4/2';
			
			case Time7_4: 	return '7/4';
			case Time6_4: 	return '6/4';
			case Time5_4: 	return '5/4';
			case Time4_4: 	return '4/4';
			case Time3_4:	return '3/4';
			case Time2_4:	return '2/4';
			
			case Time2_8: 	return '2/8';
			case Time3_8: 	return '3/8';
			case Time4_8: 	return '4/8';
			case Time5_8: 	return '5/8';
			case Time6_8: 	return '6/8';
			case Time7_8: 	return '7/8';
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
			case '4/2':		return ETime.Time4_2;
			case '3/2':		return ETime.Time3_2;
			case '224':		return ETime.Time2_2;
			
			case '7/4':		return ETime.Time7_4;
			case '6/4':		return ETime.Time6_4;
			case '5/4':		return ETime.Time5_4;
			case '4/4':		return ETime.Time4_4;
			case '3/4':		return ETime.Time3_4;
			case '2/4':		return ETime.Time2_4;
			
			case '2/8':		return ETime.Time2_8;
			case '3/8':		return ETime.Time3_8;
			case '4/8':		return ETime.Time4_8;
			case '5/8':		return ETime.Time5_8;
			case '6/8':		return ETime.Time6_8;
			case '7/8':		return ETime.Time7_8;
			case '9/8':		return ETime.Time9_8;
			case '12/8':	return ETime.Time12_8;
			
			case 'Common': return ETime.TimeCommon;
			case 'Allabreve': return ETime.TimeAllabreve;
			default: 			return null;			
		}
		return null;
	}
}
package nx.enums.utils;
import nx.enums.ETime;

/**
 * ...
 * @author Jonas Nyström
 */

class ETimeTools 
{

	static public function nextTime(time:ETime): ETime {
		
		if (time == null) return ETime.Time4_4;
		var result:ETime = ETime.Time4_4;
		switch (time) {
			
			case ETime.Time2_8: result = ETime.Time3_8;
			case ETime.Time3_8: result = ETime.Time4_8;
			case ETime.Time4_8: result = ETime.Time5_8;
			case ETime.Time5_8: result = ETime.Time6_8;
			case ETime.Time6_8: result = ETime.Time7_8;
			case ETime.Time7_8: result = ETime.Time9_8;
			case ETime.Time9_8: result = ETime.Time12_8;
			case ETime.Time12_8: result = ETime.Time2_4;
			
			case ETime.Time2_4: result = ETime.Time3_4;
			case ETime.Time3_4: result = ETime.Time4_4;
			case ETime.Time4_4: result = ETime.TimeCommon;
			case ETime.TimeCommon: result = ETime.Time5_4;
			case ETime.Time5_4: result = ETime.Time6_4;
			case ETime.Time6_4: result = ETime.Time7_4;
			case ETime.Time7_4: result = ETime.Time2_2;
			
			case ETime.Time2_2: result = ETime.TimeAllabreve;
			case ETime.TimeAllabreve: result = ETime.Time3_2;
			case ETime.Time3_2: result = ETime.Time4_2;
			case ETime.Time4_2: result = null;

			default: result = ETime.Time4_4;
			
		}
		return result;
	}
	
}

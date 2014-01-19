package nx3.elements;

/**
 * ...
 * @author Jonas Nyström
 */
typedef ConfigDBar =
{
	?type:				EBarType,
	?time:				ETime,
	?barline:			EBarline,
	?barlineLeft:		EBarlineLeft,
	?ackolade:			EAckolade,
	?IndentLeft:		Null<Float>,
	?IndentRight:		Null<Float>,	
	?allotment:		EAllotment,
	
	?configParts: 		Array<ConfigDPart>,
}

class ConfigDBarDefaults 
{
	static public function getDefaults():ConfigDBar
	{
		return {
			type: EBarType.Normal, 
			time: ETime.Time3_4,
			barline: EBarline.Normal,
		}
	}
	
}
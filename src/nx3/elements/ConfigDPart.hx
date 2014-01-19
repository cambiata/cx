package nx3.elements;

/**
 * ...
 * @author Jonas Nyström
 */
typedef ConfigDPart =
{
	?type			:EPartType,
	?key				:EKey,
	?clef				:EClef,
	?label			:Null<String>,
	?beaming		: BProcessor,
	?configVoices	:Array<ConfigDVoice>,
}

class ConfigDPartDefaults 
{
	static public function getDefaults():ConfigDPart
	{
		return {
			type: EPartType.Normal ,
			key: EKey.Natural,
			clef: EClef.ClefC,
		}
	}
	
}
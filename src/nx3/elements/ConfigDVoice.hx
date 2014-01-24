package nx3.elements;
import nx.display.beam.BeamGroupFrame;

/**
 * ...
 * @author Jonas Nyström
 */
typedef ConfigDVoice =
{
	?type				: EVoiceType ,
	?direction		: EDirectionUAD,
	?beaming		: Array<ENoteValue>,
}

class ConfigDVoiceDefaults 
{
	static public function getDefaults():ConfigDVoice
	{
		return {
			type: EVoiceType.Normal,
			direction: EDirectionUAD.Auto,
			beaming: [ENoteValue.Nv4],
		}
	}
	
}

class ConfigDVoiceTools {
	
	static public function normalize()
	{
		
		
	}
}
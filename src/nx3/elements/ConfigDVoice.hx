package nx3.elements;
import nx.display.beam.BeamGroupFrame;

/**
 * ...
 * @author Jonas Nyström
 */
typedef ConfigDVoice =
{
	?type			: EVoiceType,
	?direction		: EDirectionUAD,
	?beaming		: BProcessor,
}

class ConfigDVoiceDefaults 
{
	static public function getDefaults():ConfigDVoice
	{
		return {
			type: EVoiceType.Normal;
			direction: EDirectionUAD.Auto,
			beaming: new BProcessor_2Eights(),
		}
	}
	
}
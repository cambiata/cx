package nx3.elements;
import nx3.elements.NNote;
import nx3.elements.EDirectionUD;
import nx3.elements.EVoiceType;

/**
 * ...
 * @author 
 */

class NVoice
{
	
	public var direction(default, null):EDirectionUAD;
	public var nnotes(default, null):Array<NNote>;
	public var type(default, null):EVoiceType;

	public function new(notes:Array<NNote>=null, ?type:EVoiceType, ?direction:EDirectionUAD) 
	{
		if (notes == null || notes == []) 
		{
			this.nnotes = null;
			this.type = EVoiceType.Barpause;
		}
		else
		{
			this.nnotes = notes;
			this.type = (type != null) ? type : EVoiceType.Normal;
		}
		this.direction = (direction != null) ? direction : EDirectionUAD.Auto ;
	}
	
}
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
	
	public var direction(default, null):EDirectionUD;
	public var notes(default, null):Array<NNote>;
	public var type(default, null):EVoiceType;

	public function new(notes:Array<NNote>=null, ?type:EVoiceType, ?direction:EDirectionUD) 
	{
		if (notes == null || notes == []) 
		{
			this.notes = null;
			this.type = EVoiceType.Barpause;
		}
		else
		{
			this.notes = notes;
			this.type = (type != null) ? type : EVoiceType.Normal;
		}
		this.direction = direction;
	}
	
}
package nx3.elements;
import nx3.elements.Note;
import nx3.enums.EDirectionUD;
import nx3.enums.EVoiceType;

/**
 * ...
 * @author 
 */
class Voice
{
	public var direction(default, null):EDirectionUD;
	public var notes(default, null):Array<Note>;
	public var type(default, null):EVoiceType;

	public function new(notes:Array<Note>=null, ?type:EVoiceType, ?direction:EDirectionUD) 
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
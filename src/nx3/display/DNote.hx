package nx3.display;
#if nme
import nme.geom.Rectangle;
#else
import flash.geom.Rectangle;
#end
import nx3.display.calc.DNoteCalc;
import nx3.elements.Note;
import nx3.enums.EDirectionUD;
import nx3.enums.ENoteType;
import nx3.units.NRect;

/**
 * ...
 * @author 
 */
class DNote extends DNoteCalc
{

	public function new(note:Note, forceDirection:EDirectionUD=null) 
	{
		switch(note.type)
		{
			case ENoteType.Note(heads, variant, articulations, attributes):
				super(note, variant, articulations, attributes, forceDirection);
			default:
				throw 'DNote should have type ENoteType.Note, but has ${note.type}';
		}
	}
	

	
}
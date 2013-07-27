package nx3.elements;
import nx3.elements.calc.DNoteCalc;
#if nme
import nme.geom.Rectangle;
#else
import flash.geom.Rectangle;
#end


/**
 * ...
 * @author 
 */
class DNote extends DNoteCalc
{
	public function new(note:NNote, forceDirection:EDirectionUD=null) 
	{
		switch(note.type)
		{
			case ENoteType.Note(heads, variant, articulations, attributes):
				super(note, variant, articulations, attributes, forceDirection);
			default:
				throw 'DNote should have type ENoteType.Note, but has ${note.type}';
		}
	}
	
	public function reset()
	{
		this.headRects_ = null;
		this.headsRect_ = null;
	}
}
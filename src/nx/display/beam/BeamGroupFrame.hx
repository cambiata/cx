package nx.display.beam;
import nx.enums.EDirectionUD;
import nx.enums.ENoteType;
import nx.enums.ENoteValue;

/**
 * ...
 * @author Jonas Nyström
 */

typedef BeamGroupFrame =
{
	direction:EDirectionUD,
	adjustX:Float,
	count:Int,
	firstStave:BeamGroupStave,
	innerStaves:BeamGroupStaves,
	lastStave:BeamGroupStave,
	slope:Float,
	firstType:ENoteType,
	firstNotevalue:ENoteValue,	
}

typedef BeamGroupStaves = Array<BeamGroupStave>;

typedef BeamGroupStave = {
	topY:Float,
	bottomY:Float,
}
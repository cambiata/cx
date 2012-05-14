package nx.display.beam;
import nx.enums.EDirectionUD;

/**
 * ...
 * @author Jonas Nyström
 */

typedef BeamGroupDimensions =
{
	direction:EDirectionUD,
	adjustX:Float,
	count:Int,
	firstStave:BeamGroupStave,
	innerStaves:BeamGroupStaves,
	lastStave:BeamGroupStave,
	slope:Float,
}

typedef BeamGroupStaves = Array<BeamGroupStave>;

typedef BeamGroupStave = {
	topY:Float,
	bottomY:Float,
}
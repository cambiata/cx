package nx3.elements.beams;
import nx3.elements.DNote;
import nx3.elements.EDirectionUD;
import nx3.elements.ENoteType;
import nx3.elements.EDirectionUD;
import nx3.elements.ENoteValue;
//import nx.display.beam.BeamGroupFrame.ESubBeam;

/**
 * ...
 * @author Jonas Nyström
 */

interface IBeamGroup {
	function getNotes():Array<DNote>;
	function getFirstNote():DNote;
	function getLastNote():DNote;
	function getNote(index:Int):DNote;
	function count():Int;	
	function getDirection():EDirectionUD;
	function setDirection(value:EDirectionUD):EDirectionUD;
	function setLevelTop(value:Int):Int;
	function setLevelBottom(value:Int):Int;
	function getLevelTop():Int;
	function getLevelBottom():Int;
	
	function getTopHeadsLevels():Array<Int>;
	function getBottomHeadsLevels():Array<Int>;
	//function getBeams16():Array<ESubBeam>;
	
	function getValue():Int;
	function getValuePosition(noteIdx:Int):Int;
	
	var firstType:ENoteType;
	var firstNotevalue:ENoteValue;
	
	
}





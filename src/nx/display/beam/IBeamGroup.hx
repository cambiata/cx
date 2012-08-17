package nx.display.beam;
import nx.display.DNote;
import nx.enums.EDirectionUD;
import nx.enums.ENoteType;
import nx.enums.ENoteValue;
import nx.display.beam.BeamGroupFrame.ESubBeam;

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
	function getBeams16():Array<ESubBeam>;
	
	var firstType:ENoteType;
	var firstNotevalue:ENoteValue;
	
	
}





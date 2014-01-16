package nx3.elements;

/**
 * ...
 * @author Jonas Nyström
 */

interface BItem {
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





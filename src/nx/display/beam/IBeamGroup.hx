package nx.display.beam;
import nx.enums.EDirectionUD;
/**
 * ...
 * @author Jonas Nyström
 */

interface IBeamGroup {
	function getNotes():Array<DisplayNote>;
	function getFirstNote():DisplayNote;
	function getLastNote():DisplayNote;
	function getNote(index:Int):DisplayNote;
	function count():Int;	
	function getDirection():EDirectionUD;
	function setDirection(value:EDirectionUD):EDirectionUD;
	function setLevelTop(value:Int):Int;
	function setLevelBottom(value:Int):Int;
	function getLevelTop():Int;
	function getLevelBottom():Int;
	
	function getTopHeadsLevels():Array<Int>;
	function getBottomHeadsLevels():Array<Int>;
	

}
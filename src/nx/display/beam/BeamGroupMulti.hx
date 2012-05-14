package nx.display.beam;
import nx.enums.EDirectionUD;
/**
 * ...
 * @author Jonas Nyström
 */

class BeamGroupMulti implements IBeamGroup {	
	public function new() {
		this.dNotes = new Array<DisplayNote>();
	}
	public var dNotes:Array<DisplayNote>;

	public function getNotes():Array<DisplayNote> {
		return this.dNotes;
	}
	public function getFirstNote():DisplayNote {		
		return dNotes[0];
	}
	public function getLastNote():DisplayNote {		
		return dNotes[dNotes.length-1];
	}
	public function getNote(index:Int):DisplayNote {
		return dNotes[index];
	}
	public function count():Int {	
		return dNotes.length;
	}
	
	private var direction:EDirectionUD;
	public function getDirection():EDirectionUD {
		return this.direction;
	}
	public function setDirection(value:EDirectionUD):EDirectionUD {
		return this.direction = value;
	}

	public var levelTop:Int;
	public function setLevelTop(value:Int):Int {
		return levelTop = value;
	}
	public function getLevelTop():Int return levelTop
	
	public var levelBottom:Int;
	public function setLevelBottom(value:Int):Int {
		return levelBottom = value;
	}
	public function getLevelBottom():Int return levelBottom
	
	public  function getTopHeadsLevels():Array<Int> {
		var ret = new Array<Int>();
		for (n in this.getNotes()) {
			ret.push(n.getLevelTop());			
		}
		return ret;
	}

	public  function getBottomHeadsLevels():Array<Int> {
		var ret = new Array<Int>();
		for (n in this.getNotes()) {
			ret.push(n.getLevelBottom ());			
		}
		return ret;
		
	}
	
	//--------------------------------------------
	public function toString():String {
		/*
		var indexes = new Array<Int>();
		for (dNote in this.dNotes) {
			indexes.push(dNote.note.index);
		}
		*/
		return 'BeamGroupMulti (' + this.levelTop + ',' + this.levelBottom + ')-' + this.direction;
	}
}
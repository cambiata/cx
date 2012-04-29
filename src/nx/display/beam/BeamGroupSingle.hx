package nx.display.beam;
import nx.enums.EDirectionUD;
/**
 * ...
 * @author Jonas Nyström
 */

class BeamGroupSingle implements IBeamGroup {
	public var dNote:DisplayNote;

	public function getNotes():Array<DisplayNote> {
		return [this.dNote];
	}
	
	public function getFirstNote():DisplayNote {		
		return dNote;
	}
	public function getLastNote():DisplayNote {		
		return dNote;
	}

	public function getNote(index:Int):DisplayNote {
		return dNote;
	}
	
	public function count():Int {	
		return 1;
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
	
	
	public function new() { }
	
	//--------------------------------------------
	public function toString():String {
		return 'BeamGroupSingle (' + this.levelTop + ',' + this.levelBottom + ')-' + this.direction;
	}
}
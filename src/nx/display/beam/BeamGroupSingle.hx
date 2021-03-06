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
class BeamGroupSingle implements IBeamGroup {
	public var dNote:DNote;

	public function new(dnote:DNote = null) {
			this.dNote = dnote;
	}	
	
	
	public function getNotes():Array<DNote> {
		return [this.dNote];
	}
	
	public function getFirstNote():DNote {		
		return dNote;
	}
	public function getLastNote():DNote {		
		return dNote;
	}

	public function getNote(index:Int):DNote {
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
	

	
	public  function getTopHeadsLevels():Array<Int> {
		var ret:Array<Int> = [this.getFirstNote().levelTop];
		return ret;
	}
	
	public  function getBottomHeadsLevels():Array<Int> {
		var ret:Array<Int> = [this.getFirstNote().levelBottom];		
		return ret;
	}	
	
	public function getBeams16():Array<ESubBeam> {
		return [ESubBeam.None];
	}
	
	public var firstType:ENoteType;
	public var firstNotevalue:ENoteValue;	
	
	public function getValue():Int return this.getFirstNote().notevalue.value
	
	public function getValuePosition(noteIdx:Int):Int return 0
	
	//--------------------------------------------
	public function toString():String {
		return 'BeamGroupSingle (' + this.levelTop + ',' + this.levelBottom + ')- direction:' + this.direction + ' count:' + this.count();
	}
}
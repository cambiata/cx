package nx3.elements.beams;
import nx3.elements.DNote;
import nx3.elements.EDirectionUD;
import nx3.elements.ENoteType;
import nx3.elements.ENoteValue;
//import nx.display.beam.BeamGroupFrame.ESubBeam;
/**
 * ...
 * @author Jonas Nyström
 */
using cx.ArrayTools;
class BeamGroupMulti implements IBeamGroup 
{	
	public function new(dNotes:Array<DNote> = null) 
	{		
		this.dNotes = (dNotes != null) ? dNotes : new Array<DNote>();
	}
	public var dNotes:Array<DNote>;

	public function getNotes():Array<DNote> {
		return this.dNotes;
	}
	public function getFirstNote():DNote {		
		return dNotes[0];
	}
	public function getLastNote():DNote {		
		return dNotes[dNotes.length-1];
	}
	public function getNote(index:Int):DNote {
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
			ret.push(n.levelTop);			
		}
		return ret;
	}

	public  function getBottomHeadsLevels():Array<Int> {
		var ret = new Array<Int>();
		for (n in this.getNotes()) {
			ret.push(n.levelBottom);	
		}
		return ret;
		
	}
	
	public var firstType:ENoteType;
	
	public var firstNotevalue:ENoteValue;
	
	private var _beams16:Array<ESubBeam>;
	
	
	/*
	public function getBeams16():Array<ESubBeam> {
		if (this._beams16 != null) return this._beams16;
		
		var beams:Array<ESubBeam> = [ESubBeam.None];
		var prevDnote:DNote = null;
		var dnote:DNote = null;
		for (dnote in this.dNotes) {
			if (prevDnote == null) {
				prevDnote = dnote;
				continue;
			}	
			
			if ((prevDnote.notevalue.beamingLevel < 2)) {				
				if ((dnote == this.dNotes.last()) && (dnote.notevalue.beamingLevel >= 2)) {
					beams.push(ESubBeam.ShortRight);
				} else {					
					beams.push(ESubBeam.None);
				}
			} else if ((prevDnote.notevalue.beamingLevel >= 2) && (dnote.notevalue.beamingLevel < 2)) {
				if (dnote == this.dNotes.first()) {
					beams.push(ESubBeam.ShortLeft);
				}
			} else if ((prevDnote.notevalue.beamingLevel >= 2) && (dnote.notevalue.beamingLevel >= 2)) {
				beams.push(ESubBeam.Full);
			}
			
			prevDnote = dnote;
		}		
		this._beams16 = beams;
		return this._beams16;
	}
	*/
	

	private var value = 0;
	private var valuePositions: Array<Int>;
	
	public function getValue():Int {
		if (this.value != 0) return this.value;
		this.valuePositions = [];
		var idx = 0;
		for (dnote in this.dNotes) {
			valuePositions[idx] = this.value;
			this.value += dnote.notevalue.value;
			idx++;
		}
		return this.value;
	}
	
	public function getValuePosition(noteIndex:Int):Int {
		if (this.valuePositions == null) this.getValue(); 
		return valuePositions[noteIndex];
	}
	
	//--------------------------------------------
	public function toString():String {
		/*
		var indexes = new Array<Int>();
		for (dNote in this.dNotes) {
			indexes.push(dNote.note.index);
		}
		*/
		return 'BeamGroupMulti (' + this.levelTop + ',' + this.levelBottom + ')- direction:' + this.direction + ' count:' + this.count();
	}
}
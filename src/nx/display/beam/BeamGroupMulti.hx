package nx.display.beam;
import nx.core.display.DNote;
import nx.enums.EDirectionUD;
import nx.enums.ENoteType;
import nx.enums.ENoteValue;
import nx.display.beam.BeamGroupFrame.ESubBeam;
/**
 * ...
 * @author Jonas Nyström
 */
using cx.ArrayTools;
class BeamGroupMulti implements IBeamGroup {	
	public function new() {
		this.dNotes = new Array<DNote>();
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
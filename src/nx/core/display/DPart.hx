package nx.core.display;
import cx.ArrayTools;
import nme.geom.Rectangle;
import nx.Constants;
import nx.core.element.Part;
import nme.ObjectHash;
import nx.enums.EPartType;

/**
 * ...
 * @author Jonas Nyström
 */

class DPart 
{
	private var _posDNotes:IntHash<Array<DNote>>;

	public var part			(default, null)		:Part;
	public var dvoices		(default, null)		:Array<DVoice>;
	public var complexes	(default, null)		:Array<Complex>;	
	public var positions		(default, null)		:Array<Int>;
	public var complexPosition(default, null)		:ObjectHash<Complex, Int>;
	public var complexDistance(default, null)	:ObjectHash<Complex, Float>;
	public var positionComplex(default, null)	:IntHash<Complex>;
	

	
	public function dplex(idx:Int)  return this.complexes[idx]
	
	public function new(part:Part=null) {		
		this.part = (part != null) ? part : new Part();		
		this._value = 0;
		
		this.dvoices = [];
		for (voice in this.part.voices) {
			this.dvoices.push(new DVoice(voice, voice.direction));
		}

		this._calcPositions();
		this._calcDComplexs();
		this._calcDistances();
	}
	
	
	private var _value:Int;
	public var value(get_value, null):Int;
	private function get_value():Int 
	{
		if (this._value != 0) return this._value;
		this._value = 0;
		for (dvoice in this.dvoices) {
			this._value = Std.int(Math.max(this._value, dvoice.value));
		}
		return this._value;
	}

	/************************************************************************
	 * Private methods
	 * 
	 ************************************************************************/
	
	private function _calcPositions() {
		this._posDNotes = new IntHash<Array<DNote>>();
		for (dvoice in this.dvoices) {
			var pos = 0;
			for (dnote in dvoice.dnotes) {
				if (!_posDNotes.exists(pos)) _posDNotes.set(pos, []); 				
				_posDNotes.get(pos).push(dnote);
				pos += dnote.notevalue.value;
			}
		}		
		this.positions = ArrayTools.fromIterator(_posDNotes.keys());
		this.positions.sort(function(a, b) { return Reflect.compare(a, b); } );		
	}

	private function _calcDComplexs() {
		this.complexes = [];
		this.complexPosition = new ObjectHash<Complex, Int>();
		this.positionComplex = new IntHash<Complex>();
		
		for (pos in this.positions) {
			var dnotes = this._posDNotes.get(pos);
			var dplex = new Complex(dnotes, this);
			this.complexes.push(dplex);			
			this.complexPosition.set(dplex, pos);
			this.positionComplex.set(pos, dplex);
		}								
	}
	
	private function _calcDistances() {
		this.complexDistance = new ObjectHash<Complex, Float>();
		var length = this.complexes.length;
		
		this.complexDistance.set(this.dplex(0), 0);
		for (i in 0...length-1) {
			var plex = this.complexes[i];
			var plexNext = this.complexes[i + 1];	
			var distanceX = plex.distanceX(plexNext);
			this.complexDistance.set(plexNext, distanceX);
		}			
	}
	
	//-----------------------------------------------------------------------------------------------------
	
	private var _rectClef:Rectangle;
	public var rectClef(get_rectClef, null):Rectangle;
	private function get_rectClef():Rectangle 
	{
		if (this._rectClef != null) return this._rectClef;
		var rect:Rectangle = null;
		
		
		if ((this.part.clef == null) || (this.part.type != EPartType.Normal)) {
			rect = new Rectangle(0, -2, Constants.ATTRIBUTE_NULL_WIDTH, 4);
			this._rectClef = rect;
			return this._rectClef;
		}
		switch(this.part.clef) {			
			default: rect = new Rectangle(0, -7, Constants.CLEF_WIDTH, 14);
		}
		this._rectClef = rect;		
		return this._rectClef;
	}
	
	private var _rectKey:Rectangle;
	public var rectKey(get_rectKey, null):Rectangle;
	private function get_rectKey():Rectangle {
		if (this._rectKey != null) return this._rectKey;
		var keyInt:Int = (this.part.key != null) ? Std.int(Math.abs(this.part.key.levelShift)) : 0;		
		
		if ((keyInt == 0) || (this.part.type != EPartType.Normal)) {
			this._rectKey = new Rectangle(0, -2, Constants.ATTRIBUTE_NULL_WIDTH, 4);
		} else {
			this._rectKey = new Rectangle(0, -6, (keyInt * Constants.SIGN_WIDTH) + Constants.ATTRIBUTE_NULL_WIDTH, 12);
		}
		
		return this._rectKey;
	}
	
	//----------------------------------------------------------------------------------------------------------
	
	private var _rectDPartHeight:Rectangle;
	public var rectDPartHeight(get_rectDPartHeight, null):Rectangle;
	private function get_rectDPartHeight():Rectangle 	{
		if (this._rectDPartHeight != null) return this._rectDPartHeight;
		
		var rect = new Rectangle(0, 0, 0, 0);
		for (complex in this.complexes) {
			rect = rect.union(complex.rectFull);			
		}
		
		/*
		rect = rect.union(this.rectKey);
		rect = rect.union(this.rectClef);		
		*/
		
		this._rectDPartHeight = rect;
		return this._rectDPartHeight;
		
	}
	
	
	
}
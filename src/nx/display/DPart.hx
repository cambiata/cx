package nx.display;
import cx.ArrayTools;
import nme.geom.Rectangle;
import nx.Constants;
import nx.display.beam.IBeamingProcessor;
import nx.element.Part;
import nme.ObjectHash;
import nx.enums.EAttributeDisplay;
import nx.enums.EClef;
import nx.enums.EKey;
import nx.enums.ENoteType;
import nx.enums.EPartType;
import nx.enums.EVoiceType;
import nx.display.type.TPartDisplaySettings;

/**
 * ...
 * @author Jonas Nyström
 */
using cx.ArrayTools;
class DPart 
{
	private var _posDNotes:IntHash<Array<DNote>>;

	public var part			(default, null)			:Part;
	public var dvoices		(default, null)			:Array<DVoice>;
	public var complexes	(default, null)			:Array<Complex>;	
	public var positions		(default, null)			:Array<Int>;
	public var complexPosition(default, null)		:ObjectHash<Complex, Int>;
	public var complexDistance(default, null)	:ObjectHash<Complex, Float>;
	public var positionComplex(default, null)	:IntHash<Complex>;
	
	public var dType(default, null)					:EPartType;
	public var dKey(default, null)					:EKey;
	public var dClef(default, null)					:EClef;
	public var dLabel(default, null)					:Null<String>;
	
	public function dplex(idx:Int)  return this.complexes[idx]
	
	public function new(part:Part=null, partDisplaySettings:TPartDisplaySettings=null, beamingProcessor:BProcessor=null) {		
		this.part = (part != null) ? part : new Part();		
		this._value = 0;
		
		this.dvoices = [];
		for (voice in this.part.voices) {
			this.dvoices.push(new DVoice(voice, voice.direction, beamingProcessor));
		}

		//----------------------------------------------------------------------------------------
		// display settings		
		
		var pds = partDisplaySettings;
		if (partDisplaySettings != null) {
			this.setDisplaySettings(partDisplaySettings);
		} else {
			this.dType = 			part.type;
			this.dClef = 			part.clef;
			this.dKey = 			part.key;
			this.dLabel =			part.label;
			if (part.clefDisplay == EAttributeDisplay.Always) 		this.dClef = part.clef;
			if (part.clefDisplay == EAttributeDisplay.Never) 		this.dClef = null;
			if (part.keyDisplay == EAttributeDisplay.Always) 		this.dKey = part.key;
			if (part.keyDisplay == EAttributeDisplay.Never) 		this.dKey = null;				
		}
		
		//----------------------------------------------------------------------------------------
		
		this._calcPositions();
		this._calcDComplexs();
		this._calcDistances();
		this._calcTextAdjustments();
		
	}
	

	
	public function setDisplaySettings(settings:TPartDisplaySettings=null) {
		this._rectClef = null;
		this._rectKey = null;
		/// Not implemented yet...
		//this._rectLabel = null; 
		
		if (settings == null) {
			settings = {
				dType		:null,
				dKey			:null,
				dClef			:null,
				dLabel		:null,
			}
		}
		
		this.dType = 			(settings.dType != null) 			? settings.dType 			: part.type;
		this.dClef = 			(settings.dClef != null) 			? settings.dClef 				: part.clef;
		this.dKey = 			(settings.dKey != null) 			? settings.dKey 				: part.key;
		this.dLabel =			(settings.dLabel != null)			? settings.dLabel			: part.label;
		
		if (part.clefDisplay == EAttributeDisplay.Always) 		this.dClef = part.clef;
		if (part.clefDisplay == EAttributeDisplay.Never) 		this.dClef = null;
		if (part.keyDisplay == EAttributeDisplay.Always) 		this.dKey = part.key;
		if (part.keyDisplay == EAttributeDisplay.Never) 		this.dKey = null;		
	}
	
	public function getDisplaySettings():TPartDisplaySettings {
		var settings:TPartDisplaySettings = {
			dType		:this.dType,
			dKey			:this.dKey,
			dClef			:this.dClef,
			dLabel		:this.dLabel,							
		}
		return settings;
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
	
	private function _calcTextAdjustments() {
		if (this.part.type == EPartType.Normal) return;
		
		/*
		trace('calc text adjustments');
		
		for (dvoice in this.dvoices) {
			var dnote = dvoice.dnotes.first();
			switch (dnote.notetype) {
				case  ENoteType.Lyric:
					var rectText = dnote.rectText;
					trace(rectText);
					var newWidth = rectText.width + rectText.x;
					var newX = 0;
					var newRect = new Rectangle(newX, rectText.y, newWidth, rectText.height);
					dnote.setRectText(newRect);
					trace(dnote.rectText);
					
					
				//case ENoteType.Tpl:
				
				default:
					trace('SOMETIING WRONG HERE - THE PART IS A TEXT ONE BUT THE NOTE IS NOT!');				
			}
		}
		*/
	}
		
	
	//-----------------------------------------------------------------------------------------------------
	
	private var _rectClef:Rectangle;
	public var rectClef(get_rectClef, null):Rectangle;
	private function get_rectClef():Rectangle 
	{
		if (this._rectClef != null) return this._rectClef;		
		this._rectClef = new Rectangle(0, -2, Constants.ATTRIBUTE_NULL_WIDTH, 4);
		if (this.dType != EPartType.Normal) return this._rectClef;
		if (this.dClef == null) return this._rectClef;
		
		switch(this.dClef) {			
			default: this._rectClef = new Rectangle(0, -7, Constants.CLEF_WIDTH, 14);
		}
			
		return this._rectClef;
	}
	
	private var _rectKey:Rectangle;
	public var rectKey(get_rectKey, null):Rectangle;
	private function get_rectKey():Rectangle {
		if (this._rectKey != null) return this._rectKey;

		if (this.dType != EPartType.Normal) 	return this._rectKey = new Rectangle(0, -2, Constants.ATTRIBUTE_NULL_WIDTH, 4);			
		if (this.dKey == null) 							return this._rectKey = new Rectangle(0, -2, Constants.ATTRIBUTE_NULL_WIDTH, 4);			
		if (this.dKey.levelShift == 0) 				return this._rectKey = new Rectangle(0, -2, Constants.ATTRIBUTE_NULL_WIDTH, 4);			
	

#if (flash || windows)		
		var keyValue = this.dKey.levelShift;
#else
		var keyValue = (this.dKey.levelShift != null) ? this.dKey.levelShift : 0;
#end

		var keyInt = Std.int(Math.abs(keyValue));
		this._rectKey = new Rectangle(0, -6, (keyInt * Constants.SIGN_WIDTH) + Constants.ATTRIBUTE_NULL_WIDTH, 12);
		
		return this._rectKey;
	}
	
	//----------------------------------------------------------------------------------------------------------
	
	private var _rectDPartHeight:Rectangle;
	public var rectDPartHeight(get_rectDPartHeight, null):Rectangle;
	private function get_rectDPartHeight():Rectangle 	{
		
		if (this._rectDPartHeight != null) return this._rectDPartHeight;
		
		var rect:Rectangle;  
		switch(this.part.type) {
			case EPartType.Lyrics:
				Constants.PART_MIN_DISTANCE;
				rect = new Rectangle(0, -3, 10, 6);			
			default: {
				rect = new Rectangle(0, -8, 10, 16);	
				for (dvoice in dvoices) {
					if (dvoice.voice.type == EVoiceType.Barpause) rect.union(new Rectangle(0, -10, 2, 20));
				}
			}
		}
		
		switch(this.part.type) {
			case EPartType.Lyrics:
			default: 
				for (complex in this.complexes) {
					rect = rect.union(complex.rectFull);			
				}				
		}
		
		this._rectDPartHeight = rect;
		return this._rectDPartHeight;
	}
	
	
	public function setRectDPartHeight(rect:Rectangle) {
		this._rectDPartHeight = rect.clone();
	}
	
	
}

/*
typedef TPartDisplaySettings = {	
	dType		:EPartType,
	dKey			:EKey,
	dClef			:EClef,
	dLabel		:Null<String>,
}
*/
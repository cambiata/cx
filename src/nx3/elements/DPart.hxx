package nx3.elements;
import cx.ArrayTools;
import haxe.ds.IntMap.IntMap;
import nx3.elements.ConfigDPart.ConfigDPartDefaults;
import nx3.elements.ConfigDVoice.ConfigDVoiceDefaults;

/**
 * ...
 * @author Jonas Nyström
 */


class DPart
{
	
	
	public var npart					(default,null)		: NPart;
	public var config					(default, null) 		: ConfigDPart;
	public var dvoices				(default,null)		: Array<DVoice>;
	public var dcomplexes			(default,null)		: Array<DComplex>;	
	public var value					(default, null)		: Int;	

	
	public var type					(default, null)		: EPartType;
	public var key						(default, null)		: EKey;
	public var clef						(default, null)		: EClef;
	public var label					(default, null)		: Null<String>;
	public var beaming				(default, null)		: BProcessor;
	
	
	public var sumNoteValue(default,null):Int;
	
	public function new(part:NPart, config:ConfigDPart=null) 
	{
		this.npart = part;
		this.config = (config == null) ? ConfigDPartDefaults.getDefaults() : config;
		
		this.type = config.type; 
		this.key = config.key;
		this.clef = config.clef;
		this.label = config.label;
		this.beaming = config.beaming;
		
		this.createChildren();
		
		/*
		this.dvoices = [];
		for (nvoice in this.part.voices) 
		{
			this.dvoices.push(new DVoice(nvoice, nvoice.direction, beamingProcessor));
		}
		this.sumNoteValue = 0;
		
		calcPositions();
		calcDComplexs();
		*/
	}
	
	public function createChildren()
	{
		var configVoices:Array<ConfigDVoice> = this.config.configVoices;
		if (configVoices == null) configVoices = [];
		var configLength = configVoices.length;
		
		if (this.npart.nvoices.length > configLength)
			for (i in configLength...this.npart.nvoices.length)
				configVoices.push(ConfigDVoiceDefaults.getDefaults());
		
		this.dvoices = [];
		
		var i = 0;
		for (nvoice in this.npart.nvoices)
		{
			this.dvoices.push(new DVoice(nvoice, configVoices[i]));
			i++;
		}
		
		this.value = 0;
		for (dvoice in this.dvoices) this.value  = Std.int(Math.max(this.value, dvoice.getValue()));
		
		this.dcomplexes = new GenerateComplexes(this).execute();
		
	}
	
	

	//public var dcomplexes(default,null):Array<DComplex>;
	public var positions		(default, null)			:Array<Int>;	
	public var complexPosition(default, null):Map<DComplex, Int>;
	public var complexDistance(default, null):Map<DComplex, Float>;
	public var positionComplex(default, null):IntMap<DComplex>;
	
	private var _posDNotes:IntMap<Array<DNote>>;
	
	private function calcPositions() 
	{
		this._posDNotes = new IntMap<Array<DNote>>();
		for (dvoice in this.dvoices) {
			var pos = 0;
			for (dnote in dvoice.dnotes) {
				if (!_posDNotes.exists(pos)) _posDNotes.set(pos, []); 				
				_posDNotes.get(pos).push(dnote);
				pos += dnote.value.value;
			}
		}		
		this.positions = ArrayTools.fromIterator(_posDNotes.keys());
		this.positions.sort(function(a, b) { return Reflect.compare(a, b); } );		
	}
	
	private function calcDComplexs() {
		this.dcomplexes = [];
		this.complexPosition = new Map<DComplex, Int>();
		this.positionComplex = new IntMap <DComplex>();
		
		for (pos in this.positions) {
			var dnotes = this._posDNotes.get(pos);
			var dplex = new DComplex(dnotes);
			this.dcomplexes.push(dplex);			
			this.complexPosition.set(dplex, pos);
			this.positionComplex.set(pos, dplex);
		}								
	}	
	
	/*
	private function calcDistances() {
		this.complexDistance = new Map<DComplex, Float>();
		var length = this.dcomplexes.length;
		
		this.complexDistance.set(this.dplex(0), 0);
		for (i in 0...length-1) {
			var plex = this.dcomplexes[i];
			var plexNext = this.dcomplexes[i + 1];	
			var distanceX = plex.distanceX(plexNext);
			this.complexDistance.set(plexNext, distanceX);
		}			
	}
	*/
		
	public function dplex(idx:Int)  return this.dcomplexes[idx];
	
	
}

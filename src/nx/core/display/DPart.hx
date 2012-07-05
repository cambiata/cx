package nx.core.display;
import cx.ArrayTools;
import nx.core.element.Part;

/**
 * ...
 * @author Jonas Nyström
 */

class DPart 
{
	public var part(default, null):Part;
	public var dvoices(default, null):Array<DVoice>;
	public  var dplexs(default, null):Array<DPlex>;	
	public var positions(default, null):Array<Int>;
	
	public function new(part:Part) {		
		this.part = part;		
		this.dvoices = [];
		this.dplexs = [];
		for (voice in this.part.voices) {
			this.dvoices.push(new DVoice(voice));
		}
			
		var dpxs = new IntHash<DPlex>();
		for (dvoice in this.dvoices) {
			var voicePosition = 0;
			for (dnote in dvoice.dnotes) {
				if (!dpxs.exists(voicePosition)) dpxs.set(voicePosition, new DPlex(voicePosition));
				dpxs.get(voicePosition).addDNote(dnote);				
				voicePosition += dnote.notevalue.value;
			}
		}
		
		this.positions = ArrayTools.fromIterator(dpxs.keys());
		this.dplexs = Lambda.array(dpxs);		
	}


	
	
}
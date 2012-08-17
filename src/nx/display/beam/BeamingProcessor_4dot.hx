package nx.display.beam;
import nx.display.DVoice;
import nx.enums.EDirectionUAD;
import nx.enums.ENoteValue;

/**
 * ...
 * @author Jonas Nyström
 */

class BeamingProcessor_4dot extends BeamingProcessorBase, implements IBeamingProcessor {	
	
	public function doBeaming(dVoice:DVoice, ?forceDirection:EDirectionUAD=null) {
		this.beam(dVoice, this.valuePattern, forceDirection);		
	}

	public function new() {
		this.valuePattern = [ENoteValue.Nv4dot/*, ENoteValue.Nv4dot, ENoteValue.Nv4dot, ENoteValue.Nv4dot*/];
	}
}
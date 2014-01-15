package nx3.elements.beams;
import nx3.elements.DVoice;
import nx3.elements.EDirectionUAD;
import nx3.elements.ENoteValue;

/**
 * ...
 * @author Jonas Nyström
 */

class BeamingProcessor_4dot extends BeamingProcessorBase implements IBeamingProcessor {	
	
	public function doBeaming(dVoice:DVoice, ?forceDirection:EDirectionUAD=null) {
		this.beam(dVoice, this.valuePattern, forceDirection);		
	}

	public function new() {
		this.valuePattern = [ENoteValue.Nv4dot/*, ENoteValue.Nv4dot, ENoteValue.Nv4dot, ENoteValue.Nv4dot*/];
	}
}
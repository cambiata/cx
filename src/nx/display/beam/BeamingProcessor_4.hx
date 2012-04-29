package nx.display.beam;
import nx.enums.EDirectionUAD;
import nx.enums.EDirectionUD;
import nx.enums.ENoteValue;
/**
 * ...
 * @author Jonas Nyström
 */

class BeamingProcessor_4 extends BeamingProcessorBase, implements IBeamingProcessor {
	//private var valuePattern:Array<ENoteValue>;

	public function doBeaming(dVoice:DisplayVoice, ?forceDirection:EDirectionUAD=null) {
		this.beam(dVoice, this.valuePattern, forceDirection);
	}
	
	public function new() {
		this.valuePattern = [ENoteValue.Nv4/*, ENoteValue.Nv4, ENoteValue.Nv4, ENoteValue.Nv4, ENoteValue.Nv4, ENoteValue.Nv4*/];
	}
}
package nx.display.layout;
import nx.Constants;
import nx.enums.ENoteValue;

/**
 * ...
 * @author Jonas Nyström
 */

class AllotmentLinear implements IAllotment
{
	public function new() {}
	
	public function getAFactor(noteValue:Int): Float {
		return noteValue / Constants.BASE_NOTE_VALUE;
	}	
}
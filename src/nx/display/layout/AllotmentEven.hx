package nx.display.layout;

/**
 * ...
 * @author Jonas Nyström
 */

class AllotmentEven implements IAllotment
{
	public function new() {}
	
	public function getAFactor(noteValue:Int): Float {
		return 1;
	}	
}
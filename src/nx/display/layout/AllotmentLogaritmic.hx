package nx.display.layout;
import nx.Constants;

/**
 * ...
 * @author Jonas Nyström
 */

class AllotmentLogaritmic implements IAllotment
{
	public function new() {}
	
	public function getAFactor(noteValue:Int): Float {
		var f:Float = 0.5;
		return f + ((noteValue / Constants.BASE_NOTE_VALUE) / 2);
	}		
}
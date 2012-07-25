package nx.core.display;
import nx.enums.EDirectionUAD;

/**
 * ...
 * @author Jonas Nyström
 */

class DPlex
{
	public function new(dnotes:Iterable<DNote>)  {
		this.dnotes = Lambda.array(dnotes);
		if (this.dnotes.length > 1) {
			trace(this.dnotes[0].rectHeads);
			trace(this.dnotes[1].rectHeads);
		}
	}
	
	public var dnotes(default, null):Array<DNote>;
}
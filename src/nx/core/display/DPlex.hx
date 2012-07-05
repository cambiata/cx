package nx.core.display;

/**
 * ...
 * @author Jonas Nyström
 */

class DPlex 
{
	public var posiiton(default, null):Int;
	public var count(default, null): Int;
	

	public function new(position:Int)  {
		this.posiiton = position;
		this.dnotes = [];
		this.count = 0;
	}
	
	public var dnotes(default, null):Array<DNote>;

	public function addDNote(dnote:DNote) {
		this.dnotes.push(dnote);
		this.count = this.dnotes.length;
	}
	
	
	
	
}
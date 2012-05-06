package nx.element.pre;

/**
 * ...
 * @author Jonas Nyström
 */

class PreArpeggio implements IPreObject {
	
	public var topOffset:Int;
	public var bottomOffset:Int;	
	
	public function new(topOffset:Int=0, bottomOffset:Int=0) {
		this.topOffset = topOffset;
		this.bottomOffset = bottomOffset;
	}
	
	
	
}
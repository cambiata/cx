package nx.core.display;
import nme.geom.Rectangle;
import nx.core.element.Head;
import nx.enums.ESign;

/**
 * ...
 * @author Jonas Nyström
 */


 using nx.enums.utils.ESignTools;
 
class DHead 
{
	public function new(head:Head) {
		this.head = head;
		this.rect = new Rectangle( -2, this.head.level - 1, 2, 4);
		this.signRect = this.head.sign.getSignRect();
	}
	
	public var head(default, null):Head;
	
	public var level(get_level, null):Int;
	private function get_level():Int {
		return this.head.level;
	}
	
	public var sign(get_sign, null):ESign;
	private function get_sign():ESign {
		return this.head.sign;
	}
	
	public var rect(default, null):Rectangle;
	public var signRect(default, null):Rectangle;
	
}

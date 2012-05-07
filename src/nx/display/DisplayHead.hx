package nx.display;
import nme.geom.Rectangle;
import nx.Constants;
import nx.element.Head;
import nx.enums.ESign;

/**
 * ...
 * @author Jonas Nyström
 */

interface IDisplayHead {
	function getHead():IHead;
	function setPosition(value:Int):IDisplayHead;
	function getPosition():Int;
	function getLevel():Int;
	function getSign():ESign;
}
 
class DisplayHead implements IDisplayHead, implements IDisplayElement
{	
	public function new(head:IHead) {
		this.position = 0;
		this.head = head;
	}
	
	private var head:IHead;
	public function getHead():IHead {
		return this.head;
	}

	private var position:Int;
	public  function setPosition(value:Int):IDisplayHead {
		this.position = cx.Tools.intRange( -1, value, 1); // Std.int(Math.min(Math.max( -1, value), 1));
		return this;
	}	
	public function getPosition():Int {
		return this.position;
	}
	
	public function getLevel():Int {
		return this.head.getLevel();
	}
	
	public function getSign():ESign {
		return this.head.getSign();
	}
	
	public function getDisplayRect():Rectangle {
		var r = new Rectangle(this.position* Constants.HEAD_WIDTH, this.getLevel(), 0, 0);
		r.inflate(Constants.HEAD_HALFWIDTH, 1);
		return r;
	}	
}


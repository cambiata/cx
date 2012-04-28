package nx.display;
import nx.element.Head;
import nx.enums.ESign;
import nx.geom.DRectangle;
import nx.Tools;
import nx.types.NxX;
import nx.types.NxY;

/**
 * ...
 * @author Jonas Nyström
 */

interface IDisplayHead {
	function getHead():Head<Dynamic>;
	function setPosition(value:Int):IDisplayHead;
	function getPosition():Int;
	function getLevel():NxY;
	function getSign():ESign;
}
 
class DisplayHead implements IDisplayHead, implements IDisplayElement
{	
	public function new(head:Head<Dynamic>) {
		this.head = head;
	}
	
	private var head:Head<Dynamic>;
	public function getHead():Head<Dynamic> {
		return this.head;
	}

	private var position:NxX;
	public  function setPosition(value:NxX):IDisplayHead {
		this.position = Tools.intRange( -1, value, 1); // Std.int(Math.min(Math.max( -1, value), 1));
		return this;
	}	
	public function getPosition():NxX {
		return this.position;
	}
	
	public function getLevel():NxY {
		return this.head.getLevel();
	}
	
	public function getSign():ESign {
		return this.head.getSign();
	}
	
	public function getDisplayRect():DRectangle {
		var r = new DRectangle(this.position*nx.Const.NConst.headDisplayWidth, this.getLevel(), 0, 0);
		r.inflate(nx.Const.NConst.headDisplayWidth / 2, 1);
		return r;
	}	
}


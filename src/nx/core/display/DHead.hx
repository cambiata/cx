package nx.core.display;
import nme.geom.Rectangle;
import nx.core.element.Head;
import nx.enums.ESign;

/**
 * ...
 * @author Jonas Nyström
 */

 interface IDHead {	 
	private function get_head():Head ;
 }

 using nx.enums.utils.ESignTools;
 
class DHead implements IDHead
{
	public function new(head:Head) 
	{
		this._head = head;
		this._rect = new Rectangle( -2, this._head.level - 1, 2, 4);
		this._signRect = this._head.sign.getSignRect();
	}

	//-----------------------------------------------------------------------------------------------------
	
	private var _head:Head;
	
	private function get_head():Head 
	{
		return _head;
	}
	
	public var head(get_head, null):Head;
	
	
	//-----------------------------------------------------------------------------------------------------
	
	public var level(get_level, null):Int;
	
	private function get_level():Int {
		return this._head.level;
	}
	
	//-----------------------------------------------------------------------------------------------------
	
	public var sign(get_sign, null):ESign;
	
	private function get_sign():ESign {
		return this._head.sign;
	}
	
	//-----------------------------------------------------------------------------------------------------

	private function get_rect():Rectangle 
	{
		return _rect;
	}
	
	public var rect(get_rect, null):Rectangle;
	
	private var _rect:Rectangle;

	//-----------------------------------------------------------------------------------------------------

	private function get_signRect():Rectangle 
	{
		return _signRect;
	}
	
	public var signRect(get_signRect, null):Rectangle;
	
	private var _signRect:Rectangle;
	
	
}

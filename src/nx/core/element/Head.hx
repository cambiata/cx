package nx.core.element;
import nx.enums.ESign;
import thx.math.Random;

/**
 * ...
 * @author Jonas Nyström
 */
interface IHead {
	private function get_level():Int;	
	private function set_level(value:Int):Int ;
	
	private function get_sign():ESign;
	private function set_sign(value:ESign):ESign;
} 
 
class Head implements IHead
{

	public function new(level:Int=0, sign:ESign=null) 
	{
		this._level = level;
		this._sign = (sign == null) ? ESign.None : sign;
	}
	
	//-----------------------------------------------------------------------------------------------------
	
	private var _level:Int;
	
	private function get_level():Int 
	{
		return _level;
	}
	
	private function set_level(value:Int):Int 
	{
		return _level = value;
	}
	
	public var level(get_level, set_level):Int;
	
	//-----------------------------------------------------------------------------------------------------
	
	private var _sign:ESign;

	private function get_sign():ESign 
	{
		return _sign;
	}
	
	private function set_sign(value:ESign):ESign 
	{
		return _sign = value;
	}
	
	public var sign(get_sign, set_sign):ESign;	
	
	//-----------------------------------------------------------------------------------------------------
	
	public function toString():String {
		return '- Head:' + this._level + ':' + this._sign;
	}
		
}

class RHead extends Head {
	
	public function new() {
		super();
		this._level = Std.int(Math.random() * 10 - 5);
		var rSign:Int = Std.int(Math.random() * 8);
		switch (rSign) {
			case 1: this._sign = ESign.Flat;
			case 2: this._sign = ESign.Natural;
			case 3: this._sign = ESign.Sharp;			
			default: this._sign = ESign.None;
		}
	}
	
	
}
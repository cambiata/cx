package nx.core.element;
import nx.enums.ESign;

/**
 * ...
 * @author Jonas Nyström
 */
 
class Head  
{
	
	public function new(level:Int=0, sign:ESign=null)  {
		//trace(sign);
		this.level = level;
		this.sign = (sign == null) ? ESign.None : sign;
		//trace(this.sign);
	}
	
	public var level(default, null):Int;
	public var sign(default, null):ESign;
	
	//-----------------------------------------------------------------------------------------------------
	
	public function toString():String {
		return '- Head:' + this.level + ':' + this.sign;
	}
		
}

class RHead extends Head {
	
	public function new() {		
		var level = Std.int(Math.random() * 10 - 5);
		var sign:ESign = null;
		var rSign:Int = Std.int(Math.random() * 8);		
		switch (rSign) {
			case 1: sign = ESign.Flat;
			case 2: sign = ESign.Natural;
			case 3: sign = ESign.Sharp;			
			default: sign = ESign.None;
		}		
		super(level, sign);		
	}
	
	
}
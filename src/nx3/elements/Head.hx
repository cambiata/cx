package nx3.elements;
import nx3.enums.ESign;
import nx3.enums.ETie;
import nx3.units.Level;
import nx3.enums.EHeadType;

/**
 * ...
 * @author Jonas Nyström
 */

class Head
{
	public function new(?type:EHeadType, ?level: Level=0, ?sign:ESign, ?tie:ETie) 
	{
		this.type = (type == null) 		? type			: EHeadType.Standard;
		this.sign = (sign == null) 		? sign 			: ESign.None;
		this.tie = (tie == null) 				? tie				: null; 
		
		this.level = level;
	}
	
	private var level:Level;
	private var type:EHeadType;
	private var sign: ESign;
	private var tie: ETie;
	
}


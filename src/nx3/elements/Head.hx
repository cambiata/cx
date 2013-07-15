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
	public function new(?type:EHeadType, ?level: Level=0, ?sign:ESign, ?tie:ETie, ?tieTo:ETie) 
	{
		this.type = (type != null)			? type			: EHeadType.Normal; 
		this.sign = (sign != null) 			? sign 			: ESign.None;
		this.tie = (tie != null) 				? tie			: null; 		
		this.tieTo = (tieTo != null) 		? tieTo		: null; 		
		this.level = level;
	}
	
	public var level(default, default):Level;
	public var type(default, default):EHeadType;
	public var sign(default, default): ESign;
	public var tie(default, default): ETie;
	public var tieTo(default, default): ETie;
	
}


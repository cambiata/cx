package nx3.elements;



/**
 * ...
 * @author Jonas Nyström
 */

class NHead
{
	
	public var level(default, default):ULevel;
	public var type(default, default):EHeadType;
	public var sign(default, default): ESign;
	public var tie(default, default): ETie;
	public var tieTo(default, default): ETie;
	
	public function new(?type:EHeadType, ?level: ULevel=0, ?sign:ESign, ?tie:ETie, ?tieTo:ETie) 
	{
		this.type = (type != null)			? type			: EHeadType.Normal; 
		this.sign = (sign != null) 			? sign 			: ESign.None;
		this.tie = (tie != null) 			? tie			: null; 		
		this.tieTo = (tieTo != null) 		? tieTo			: null; 		
		this.level = level;
	}	
	
}


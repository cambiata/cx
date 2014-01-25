package nx3.elements;

/**
 * ...
 * @author Jonas Nyström
 */
class NBar
{

	public function new(parts:Array<NPart>=null, ?type:EBarType, ?time:ETime=null, ?timeDisplay:EDisplayALN=null ) 
	{		
		this.nparts = parts;
		this.type = (type == null) ? EBarType.Normal : type;
		this.time = (time == null) ? ETime.Time4_4 : time;
		this.timeDisplay = (timeDisplay == null) ? EDisplayALN.Layout :  timeDisplay;
	}

	public var nparts(default, null):Array<NPart>;
	public var type(default, null):EBarType;
	public var time(default, null):ETime;
	public var timeDisplay(default, null):EDisplayALN;
	
}


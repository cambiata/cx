package nx3.elements;

/**
 * ...
 * @author Jonas Nyström
 */
class NBar
{

	public function new(parts:Array<NPart>=null, ?type:EBarType, ?time:ETime=null, ?timeDisplay:EDisplayALN=null ) 
	{		
		this.parts = parts;
		this.type = (type == null) ? EBarType.Normal : type;
		this.time = time;
		this.timeDisplay = timeDisplay;
	}

	public var parts(default, null):Array<NPart>;
	public var type(default, null):EBarType;
	public var time(default, null):ETime;
	public var timeDisplay(default, null):EDisplayALN;
	
}


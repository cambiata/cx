package nx3.elements;


/**
 * ...
 * @author Jonas Nyström
 */
class NPart
{

	public function new(voices:Array<NVoice>=null, ?type:EPartType=null, clef:EClef=null, clefDisplay:EDisplayALN=null, key:EKey=null, keyDisplay:EDisplayALN=null) 
	{
		this.nvoices = voices;
		if (this.nvoices.length > 2)
		{
			throw "For now, NPart can't have more than two voices";
		}
		this.type = (type == null) ? EPartType.Normal : type;
		this.clef = (clef == null) ? EClef.ClefG : clef;
		this.clefDisplay = (clefDisplay == null) ? EDisplayALN.Layout : clefDisplay;
		this.key = (key == null) ? EKey.Natural : key;
		this.keyDisplay = (keyDisplay == null) ? EDisplayALN.Layout : keyDisplay;
	}

	public var type(default, default):EPartType;
	public var nvoices(default, default):Array<NVoice>;
	public var clef(default, default):EClef;
	public var clefDisplay(default, default):EDisplayALN;
	public var key(default, default):EKey;
	public var keyDisplay(default, default):EDisplayALN;	
	
	public function toString() return Std.string(this);
	
}
package nx3.elements;


/**
 * ...
 * @author Jonas Nyström
 */
class NPart
{
	
	public var type(default, null):EPartType;
	public var voices(default, null):Array<NVoice>;
	public var clef(default, null):EClef;
	public var clefDisplay(default, null):EDisplayALN;
	public var key(default, null):EKey;
	public var keyDisplay(default, null):EDisplayALN;

	public function new(voices:Array<NVoice>=null, ?type:EPartType=null, clef:EClef=null, clefDisplay:EDisplayALN=null, key:EKey=null, keyDisplay:EDisplayALN=null) 
	{
		this.voices = voices;
		if (this.voices.length > 2)
		{
			throw "NPart can't have more than two voices";
		}
		this.type = (type == null) ? EPartType.Normal : type;
		this.clef = clef;
		this.clefDisplay = clefDisplay;
		this.key = key;
		this.keyDisplay = keyDisplay;
	}
	
}
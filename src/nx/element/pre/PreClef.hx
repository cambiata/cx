package nx.element.pre;
import nx.enums.EClef;

/**
 * ...
 * @author Jonas Nyström
 */

class PreClef implements IPreObject
{

	public var clef(default, null):EClef;
	public var levelOffset(default, null):Int;
	public function new(clef:EClef, levelOffset:Int=0) 
	{
		this.clef = clef;
		this.levelOffset = levelOffset;
	}
	
}
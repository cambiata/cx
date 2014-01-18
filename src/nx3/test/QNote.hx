package nx3.test;
import nx3.elements.ENoteValue;
import nx3.elements.NHead;
import nx3.elements.NNote;

/**
 * ...
 * @author Jonas Nyström
 */
class QNote extends NNote
{

	public function new(?headLevel:Int=null, ?headLevels:Array<Int>=null, ?head:NHead=null, ?heads:Array<NHead>=null, ?value : ENoteValue=null) 
	{
		//var heads:Array<NHead> = null;
		if (headLevel != null) heads = [new NHead(headLevel)];
		
		if (headLevels != null) 
		{
			heads = [];
			for (level in headLevels) heads.push(new NHead(level));
		}

		if (head != null) heads = [head];
		
		if (heads == null) heads = [new NHead(0)];
		
		if (value == null) value = ENoteValue.Nv4;
		
		super(heads, value);
	}
	
}

class QNote8 extends QNote
{
	public function new(?headLevel:Int=null, ?headLevels:Array<Int>=null) 
	{
		super(headLevel, headLevels, ENoteValue.Nv8);
	}
}

class QNote2 extends QNote
{
	public function new(?headLevel:Int=null, ?headLevels:Array<Int>=null) 
	{
		super(headLevel, headLevels, ENoteValue.Nv2);
	}
}

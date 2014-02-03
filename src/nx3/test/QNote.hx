package nx3.test;
import nx3.elements.ESign;
import nx3.elements.EHeadType;
import nx3.elements.ENoteValue;
import nx3.elements.EDirectionUAD;
import nx3.elements.NHead;
import nx3.elements.NNote;

/**
 * ...
 * @author Jonas Nyström
 */
class QNote extends NNote
{

	public function new(?headLevel:Int=null, ?headLevels:Array<Int>=null, ?head:NHead=null, ?heads:Array<NHead>=null, ?value : ENoteValue=null, ?signs:String='', ?direction:EDirectionUAD=null) 
	{
		//var heads:Array<NHead> = null;
		
		signs += '...........';
		var aSigns = signs.split('');
		
		if (headLevel != null)  headLevels = [headLevel];
		if (headLevels != null) 
		{
			heads = [];
			var i = 0;
			for (level in headLevels) heads.push(new NHead(level, getSign(aSigns[i++])));
		}

		if (head != null) heads = [head];
		
		if (heads == null) heads = [new NHead(0)];
		
		if (value == null) value = ENoteValue.Nv4;
		
		
		
		
		super(heads, value, direction);
	}
	
	private function getSign(val:String):ESign
	{
		switch (val)
		{
			case '#': return ESign.Sharp;
			case 'b': return ESign.Flat;
			case 'N', 'n': return ESign.Natural;
			default: return null;
		}
	}	

}




class QNote4 extends QNote
{
	public function new(?headLevel:Int=null, ?headLevels:Array<Int>=null, ?signs:String='') 
	{
		super(headLevel, headLevels, ENoteValue.Nv4, signs);
	}
}

class QNote8 extends QNote
{
	public function new(?headLevel:Int=null, ?headLevels:Array<Int>=null, ?signs:String='') 
	{
		super(headLevel, headLevels, ENoteValue.Nv8);
	}
}

class QNote2 extends QNote
{
	public function new(?headLevel:Int=null, ?headLevels:Array<Int>=null, ?signs:String='') 
	{
		super(headLevel, headLevels, ENoteValue.Nv2);
	}
}

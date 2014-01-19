package nx3.elements;
import nx3.Constants;

/**
 * ...
 * @author Jonas Nyström
 */
class Allotator
{
	
	var allotment : EAllotment;
	
	public function new( ea: EAllotment)
	{
		this.allotment = ea;
	}

	public function delta(value : Int) : Float
	{
		switch (allotment) {
			case EAllotment.Equal: 
					return 1;
			case EAllotment.Linear: 
					return value / Constants.BASE_NOTE_VALUE;
			case EAllotment.Logaritmic:					
					return .5 + (value / Constants.BASE_NOTE_VALUE) / 2;
			default:
					return 1;
		}		
	}
}
package nx.enums.utils;
import nx.Constants;
import nx.enums.EAllotment;

/**
 * ...
 * @author Jonas Nyström
 */

class EAllotmentCalculator 
{
	static inline var delta:Float = 0.5;
	
	static public function aWidthX(allotment:EAllotment, widthX:Float, value:Int=0):Float {
		if (value == 0) value = Constants.BASE_NOTE_VALUE;
		switch (allotment) {
			case EAllotment.Equal: 
					return Math.max(widthX, Constants.ASPACING_NORMAL);
			case EAllotment.Linear: 
					var columnWidthX = (value / Constants.BASE_NOTE_VALUE) * Constants.ASPACING_NORMAL;
					return Math.max(widthX, columnWidthX);
			case EAllotment.Logaritmic:
					var columnWidthX = (delta +(value / Constants.BASE_NOTE_VALUE) / 2) * Constants.ASPACING_NORMAL;
					return Math.max(widthX, columnWidthX);
			default:
					return widthX;
		}		
	}
	
	static public function aSuperX(allotment:EAllotment, widthX:Float, value:Int=0):Float {
		if (value == 0) value = Constants.BASE_NOTE_VALUE;
		switch (allotment) {
			case EAllotment.Equal: 
					return Math.max(widthX - Constants.ASPACING_NORMAL, 0);
			case EAllotment.Linear: 
					var columnWidthX = (value / Constants.BASE_NOTE_VALUE) * Constants.ASPACING_NORMAL;
					return Math.max(widthX - columnWidthX, 0);			
			case EAllotment.Logaritmic:					
					var columnWidthX = (delta +(value / Constants.BASE_NOTE_VALUE) / 2) * Constants.ASPACING_NORMAL;
					return Math.max(widthX - columnWidthX, 0);			
			default:
					return widthX;
		}		
	}	
	
	static public function valueFactor(allotment:EAllotment, value:Int):Float {
		switch (allotment) {
			case EAllotment.Equal: 
					return 1;
			case EAllotment.Linear: 
					return value / Constants.BASE_NOTE_VALUE;
			case EAllotment.Logaritmic:					
					return delta + (value / Constants.BASE_NOTE_VALUE) / 2;
			default:
					return 1;
		}			
	}
	

	
}
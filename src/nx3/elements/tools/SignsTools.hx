package nx3.elements.tools;
import nx3.elements.TSigns;
import nx3.elements.TSign;
import nx3.elements.ESign;
import nx3.Constants;
import nx3.units.NRect;

/**
 * ...
 * @author 
 */
class SignsTools
{

	static var BREAKPOINT:Int = 5;
	
	static public function adjustPositions(signs:TSigns):TSigns {
		signs = removeNones(signs);
		//debug(signs);
		if (signs.length < 2) return signs;
		signs = sortSigns(signs);
		signs = calcPositions(signs);
		//debug(signs);
		return signs;
	}
	
	static private function calcPositions(signs:TSigns):TSigns {
		var levels = [-999, -999, -999, -999];		
		for (sign in signs) {		
			var cpos = 0;
			var diff = sign.level - levels[cpos];
			while (diff < BREAKPOINT) {
				cpos++;
				diff = sign.level - levels[cpos];
			}
			levels[cpos] = sign.level;
			sign.position = cpos;
		}
		return signs;
	}
	
	static private function removeNones(signs:TSigns):TSigns {
		var r:TSigns = [];
		for (sign in signs) {
			//trace(sign);
			if (sign.sign != ESign.None) r.push(sign);
		}
		return r;
	}
	
	static private function sortSigns(signs:TSigns):TSigns {
		signs.sort(function(signA, signB) {
			if (signA.level <= signB.level) { return -1; }
			else { return 1; }
		});
		return signs;		
	}
	
	static public function getPositions(signs:TSigns):Array<Int> {
		return Lambda.array(Lambda.map(signs, function(sign) { return sign.position; } ));
	}
	
	//------------------------------------------------------------------------------------------------------------------------------
	
	static public function getSignRect(sign:ESign):NRect
	{
		switch (sign)
		{
			case ESign.None:
				return null;
			case ESign.DoubleSharp:
				return new NRect( 0, -1.5, Constants.SIGN_NORMAL_WIDTH, 3);
			case ESign.ParFlat, ESign.ParSharp, ESign.ParNatural:
				return new NRect( 0, -2, Constants.SIGN_PARENTHESIS_WIDTH, 4);
			case ESign.Flat:
				return new NRect(0, -3, Constants.SIGN_NORMAL_WIDTH, 5);
			default:	
				return new NRect( 0, -3,Constants.SIGN_NORMAL_WIDTH, 6);
		}
		throw "This shouldn't happen!";
		return null;
	}	
	
	static public function adjustSignFontX(sign:ESign):Float
	{
		switch (sign)
		{
			case (ESign.Flat): return 0.3;
			case (ESign.Natural): return 0.3;
			default:
			
		}
		return 0;
		
	}
	
	
}
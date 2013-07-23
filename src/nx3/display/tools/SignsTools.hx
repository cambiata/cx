package nx3.display.tools;
import nx3.types.TSigns;
import nx3.types.TSign;
import nx3.enums.ESign;
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
				return new NRect( 0, -1.5, 5, 3);
			case ESign.ParFlat, ESign.ParSharp, ESign.ParNatural:
				return new NRect( 0,-2, 5, 4);
			default:	
				return new NRect( 0, -2, 3, 4);
		}
		throw "This shouldn't happen!";
		return null;
	}	
	
	
}
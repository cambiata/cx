package nx.core.util;
import nme.geom.Rectangle;
import nx.core.type.TSigns;
import nx.enums.ESign;

/**
 * ...
 * @author Jonas Nyström
 */

class SignsUtil {
	
	static var BREAKPOINT:Int = 6;
	
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
			while (diff < SignsUtil.BREAKPOINT) {
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
	
	static public function debug(signs:TSigns) {
		trace('');
		for (sign in signs) {
			trace(sign);
		}
	}
	
	static public function getDisplayRectSigns(signs:TSigns):Rectangle {
		var resultRect:Rectangle = null;
		for (sign in signs) {
			var signRect = new Rectangle(sign.position * -3, sign.level - 3, 3, 6);
			if (resultRect == null) {
				resultRect = signRect.clone();
			} else {
				resultRect = resultRect.union(signRect);
			}
		}	
		if (resultRect == null) resultRect = new Rectangle( 0.0, 0.0, 0.0, 0.0 );		
		resultRect.offset(-resultRect.left, 0) ;		
		return resultRect;
	}
	
}
package cx;
import nme.events.KeyboardEvent;
/**
 * ...
 * @author Jonas Nyström
 */

class KeyboardTools 
{

	static public function getKeyCode(e:KeyboardEvent) {
		var keyCode = e.keyCode;
		
		#if (neko || cpp) 
			if (e.keyCode == e.charCode)
				if (keyCode >= 65 && keyCode <= 122) {
					keyCode = keyCode-32;
				}
		#end		
		
		return keyCode;
	}
	
}
package nx.enums.utils;

/**
 * ...
 * @author Jonas Nyström
 */

class EDirectionTools 
{

	static public function UADtoUD(uad:EDirectionUAD):EDirectionUD {
		if (uad == null) return null;
		switch(uad) {
			case EDirectionUAD.Up: return EDirectionUD.Up;
			case EDirectionUAD.Down: return EDirectionUD.Down;
			default: return null;
		}
		return null;
	}
	
}
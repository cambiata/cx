package nx3.elements;

/**
 * ...
 * @author Jonas Nyström
 */

enum EDirectionUD {
	Up;
	Down;
}

class EDirectionUDTools {
	
	static public function toUAD(direction:EDirectionUD)
	{
		return (direction == EDirectionUD.Up) ? EDirectionUAD.Up : EDirectionUAD.Down;
	}
	
	
}
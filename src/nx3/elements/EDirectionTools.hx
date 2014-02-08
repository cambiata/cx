package nx3.elements;

/**
 * ...
 * @author Jonas Nyström
 */
class EDirectionTools
{

	static public function uadToUd(directionUAD:EDirectionUAD) : EDirectionUD
	{
		if (directionUAD == EDirectionUAD.Up) return EDirectionUD.Up;
		return EDirectionUD.Down;
	}
	
}
package nx3.elements;

/**
 * ...
 * @author Jonas Nyström
 */

enum EDirectionUAD {
	Up;
	Auto;
	Down;
}


class EDirectionUADTools {
	
	static public function toUD(direction:EDirectionUAD): EDirectionUD
	{
		//return (direction = EDirectionUD.Up) ? EDirectionUAD.Up : EDirectionUAD.Down;
		switch (direction)
		{
			case EDirectionUAD.Up: return EDirectionUD.Up;
			case EDirectionUAD.Down: return EDirectionUD.Down;
			default: return EDirectionUD.Down;
		}
		
	}
	
	
}
package nx.element.pre;
import nme.geom.Rectangle;

/**
 * ...
 * @author Jonas Nyström
 */

class PreApoggiatura implements IPreObject
{
	public function new() 
	{
		
	}	
	
	public function getDisplayRect():Rectangle {
		return new Rectangle(0, -1, 3, 2);
	}
}
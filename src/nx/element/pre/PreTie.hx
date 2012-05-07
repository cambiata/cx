package nx.element.pre;
import nme.geom.Rectangle;
import nx.const.Constants;

/**
 * ...
 * @author Jonas Nyström
 */

class PreTie implements IPreObject
{

	public function new() 
	{
		
	}
	
	public function getDisplayRect():Rectangle {
		return new Rectangle(0, -1, Constants.HEAD_WIDTH * 2, 2);
	}		
	
}
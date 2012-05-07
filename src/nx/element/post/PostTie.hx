package nx.element.post;
import nme.geom.Rectangle;
import nx.Constants;

/**
 * ...
 * @author Jonas Nyström
 */

class PostTie implements IPostObject
{

	public function new() 
	{
		
	}
	
	public function getDisplayRect():Rectangle {
		return new Rectangle(0, -1, Constants.HEAD_WIDTH * 2, 2);
	}	
	
}
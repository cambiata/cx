package cx.geom;
import nme.geom.Rectangle;

/**
 * ...
 * @author Jonas Nyström
 */

class TestPolyRect implements IPolyRect
{
	private var rects:Array<Rectangle>;
	//private var _rects:Array<Rectangle>;

	public function new(rects:Iterable<Rectangle>) 
	{
		this.rects = Lambda.array(rects);
	}
	
	public function getRects():Array<Rectangle> 
	{
			return this.rects;
	}
	
	
	

	
	
	
}
package nx3.elements.interfaces;
import nx3.geom.Rectangle;

/**
 * ...
 * @author 
 */
interface IDistanceRects
{
	var rectsFront(get, null): Array<Rectangle>;
	var rectCenter(get, null): Rectangle;
	var rectsBack(get, null): Array<Rectangle>;
}
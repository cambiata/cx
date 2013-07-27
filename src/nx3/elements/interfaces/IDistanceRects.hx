package nx3.elements.interfaces;
import flash.geom.Rectangle;

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
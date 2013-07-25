package nx3.elements.interfaces;
import nx3.units.NRect;

/**
 * ...
 * @author 
 */
interface IDistanceRects
{
	var rectsFront(get, null): Array<NRect>;
	var rectCenter(get, null): NRect;
	var rectsBack(get, null): Array<NRect>;
}
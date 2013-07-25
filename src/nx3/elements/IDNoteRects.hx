package nx3.elements;
import nx3.units.NRect;

/**
 * ...
 * @author 
 */
interface IDNoteRects
{
	var rectsFront(get, null): Array<NRect>;
	var rectsBack(get, null): Array<NRect>;
}
package nx.display;
import cx.geom.IPolyRect;
import nme.geom.Rectangle;

/**
 * ...
 * @author Jonas Nyström
 */

class DisplayCluster implements IDisplayElement, implements IPolyRect
{
	private var displayNotes:Array<DisplayNote>;

	public function new(displayNotes:Iterable<DisplayNote>) 
	{
		this.displayNotes = Lambda.array(displayNotes);
	}
	
	public function addDisplayNote(displayNote:DisplayNote) {
		this.displayNotes.push(displayNote);
	}
	
	/* INTERFACE nx.display.IDisplayElement */
	
	public function getDisplayRect():Rectangle 
	{
		return null;
	}
	
	/* INTERFACE cx.geom.IPolyRect */
	
	public function getRects():Array<Rectangle> 
	{
		return null;
	}
	
}
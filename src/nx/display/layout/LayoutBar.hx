package nx.display.layout;
import nx.display.DisplayBar;
import nx.output.Scaling;

/**
 * ...
 * @author Jonas Nyström
 */

class LayoutBar 
{
	private var displayBar:DisplayBar;
	private var scaling:Scaling;
	private var allotment:IAllotment;
	
	public function new(displayBar:DisplayBar, allotment:IAllotment=null, scaling:Scaling=null) {
		this.displayBar = displayBar;
		this.allotment = allotment;
		this.scaling = scaling;		
		
		trace (displayBar.getDisplayNotePositionsXPositions());
		trace(displayBar.getPositionsArray());
		trace(displayBar.getValuesArray());
		trace(displayBar.getExcessArray());
		trace(displayBar.getEndXPosition());
		trace(displayBar.getValue());
	}
	
	public function stretch(stretchX:Float) {
		
		
	}
	
	
}
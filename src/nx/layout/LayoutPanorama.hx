package nx.layout;
import nx.display.DBars;
import nx.display.DSystem;

/**
 * ...
 * @author Jonas Nyström
 */

class LayoutPanorama extends LayoutBase, implements ILayoutProcessor
{

	/*
	 * *********************************************************
	 * CONSTRUCTOR
	 * *********************************************************
	 *
	*/
	
	public function new() {
		super();
	}
	
	/* INTERFACE nx.layout.ILayoutProcessor */
	
	public function doLayout(dbars:DBars, firstBarNr:Int=0):Array<DSystem> {
		return null;
	}
	
	/*
	 * *********************************************************
	 * 
	 * *********************************************************
	 *
	*/	
	

	
}
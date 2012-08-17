package nx.layout;
import nx.display.DBars;
import nx.display.DSystem;

/**
 * ...
 * @author Jonas Nyström
 */

class LayoutWebpage extends LayoutBase, implements ILayoutProcessor
{

	/*
	 * *********************************************************
	 * CONSTRUCTOR
	 * *********************************************************
	 *
	*/
	
	public function new(systemWidth:Float = 400.0, systemsHeight=800.0) {
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
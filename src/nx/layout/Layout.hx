package nx.layout;
import nx.core.display.DBar;
import nx.core.display.DSystem;
import nx.core.element.Bars;

/**
 * ...
 * @author Jonas Nyström
 */

class Layout 
{

	/*
	 * *********************************************************
	 * CONSTRUCTOR
	 * *********************************************************
	 *
	*/
	
	private var dbars:Array<DBar>;
	private var layoutProc:ILayoutProcessor;
	private var systems:Array<DSystem>;
	
	public function new(bars:Bars, layoutProc:ILayoutProcessor=null) {
		this.dbars = [];
		for (bar in bars) {
			var dbar = new DBar(bar);			
		}
		
		this.layoutProc = layoutProc;		
	}
	
	public function doLayout(systemWidth:Float = 800.0, firstBarNr:Int=0) {
		this.systems = this.layoutProc.doLayout(systemWidth, firstBarNr);		
	}
	
	
	/*
	 * *********************************************************
	 * 
	 * *********************************************************
	 *
	*/	
	

	
}
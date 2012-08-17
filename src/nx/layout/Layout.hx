package nx.layout;
import nx.display.DBar;
import nx.display.DBars;
import nx.display.DSystem;
import nx.element.Bars;

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
	
	public var dbars(default, null)			:DBars;
	public var layoutProc(default, null)	:ILayoutProcessor;
	public var systems(default, null)		:Array<DSystem>;
	
	public function new(bars:Bars, layoutProc:ILayoutProcessor=null) {
		this.dbars = [];
		for (bar in bars.bars) {
			var dbar = new DBar(bar);		
			this.dbars.push(dbar);
		}
		
		this.layoutProc = layoutProc;		
	}
	
	public function doLayout(firstBarNr:Int = 0) {
		var dbars = this.dbars;
		this.systems = this.layoutProc.doLayout(dbars);		
	}
	
	
	/*
	 * *********************************************************
	 * 
	 * *********************************************************
	 *
	*/	
	

	
}
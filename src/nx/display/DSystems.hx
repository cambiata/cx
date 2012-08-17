package nx.display;
import nx.element.Bars;
import nx.layout.ILayoutProcessor;
/**
 * ...
 * @author Jonas Nyström
 */

class DSystems 
{

	public var dbars(default, null)			:DBars;
	public var layoutProc(default, null)		:ILayoutProcessor;
	public var systems(default, null)		:Array<DSystem>;
	
	public function new(bars:Bars, layoutProc:ILayoutProcessor=null) {
		this.dbars = [];
		for (bar in bars.bars) {
			var dbar = new DBar(bar);		
			this.dbars.push(dbar);
		}
		
		this.layoutProc = layoutProc;	
		
		this.systems = this.layoutProc.doLayout(dbars);		
		
	}
	
	private function doLayout() {

	}
	
	
	
}

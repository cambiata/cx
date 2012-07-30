package nx.core.display;
import nx.core.element.Bar;

/**
 * ...
 * @author Jonas Nyström
 */

class DBar 
{
	private var _dparts:Array<DPart>;
	public var bar(default, null):Bar;
	
	public function new(bar:Bar=null) 
	{
		this.bar = (bar != null) ? bar : new Bar();
		
		this._dparts = [];
		for (part in this.bar.parts) {
			this._dparts.push(new DPart(part));
		}		
	}
}
package nx.core.display;
import cx.ArrayTools;
import nme.geom.Rectangle;
import nx.core.element.Bar;

/**
 * ...
 * @author Jonas Nyström
 */

class DBar 
{
	public var dparts					(default, null)		:Array<DPart>;
	public var bar						(default, null)		:Bar;
	public var positions				(default, null)		:Array<Int>;
	public var positionDistance	(default, null)		:IntHash<Float>;
	public var postionDistpos		(default, null)		:IntHash<Float>;
	
	private var _plexboxes:Array<PlexBox>;
	
	public function new(bar:Bar=null) {				
		this.bar = (bar != null) ? bar : new Bar();				
		this.dparts = [];
		for (part in this.bar.parts) {
			this.dparts.push(new DPart(part));
		}				
		this._calcPositions();
		this._calcPlexBoxes();
	}

	/************************************************************************
	 * Private methods
	 * 
	 ************************************************************************/
	
	private function _calcPositions() {
		this.positions = [];
		for (dpart in this.dparts) {
			this.positions  = this.positions.concat(dpart.positions);
		}	
		this.positions = ArrayTools.unique(this.positions);
		this.positions.sort(function(a, b) { return Reflect.compare(a, b); } );
		trace(this.positions);
	}
	
	private function _calcPlexBoxes() {		
		this._plexboxes = [];		
		for (pos in this.positions) {			
			var plexbox = new PlexBox(pos);			
			for (dpart in this.dparts) {
				var dplex = dpart.positionDplex.get(pos);				
				plexbox.addDpart(dpart);																		
			}
			trace(plexbox.dparts.length);
			this._plexboxes.push(plexbox);			
		}
	}	
	
}

class PlexBox {
	public var position(default, null):Int;
	public var dparts(default, null):Array<DPart>;
	public var dplexs(default, null):Array<DPlex>;
	public var rectAll(default, null): Rectangle;
	
	public function new(position:Int) {
		this.position = position;
		this.dparts = [];
		this.dplexs = [];
	}
	
	public function addDpart(dpart:DPart) {
		this.dparts.push(dpart);
		this.dplexs.push(dpart.positionDplex.get(this.position));
	}	
}
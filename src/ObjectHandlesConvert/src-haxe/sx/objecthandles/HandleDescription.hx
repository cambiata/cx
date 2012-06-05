package sx.objecthandles;
import flash.geom.Point;

/**
 * ...
 * @author Jonas Nyström
 */

class HandleDescription {	
	public var role:Int;
	public var percentageOffset:Point;
	public var offset:Point;
	public var handleFactory:IFactory;
	public var constraint:IFactory;	

	public function new(role:Int, percentageOffset:Point, offset:Point, ?handleFactory:IFactory=null, ?constraint:IFactory=null ) {
		this.role = role;
		this.percentageOffset = percentageOffset;
		this.offset = offset;
		this.handleFactory = handleFactory;
		this.constraint = constraint;		
	}
}
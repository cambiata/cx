package nx.geom;
import nme.geom.Rectangle;

/**
 * ...
 * @author Jonas Nyström
 */


class DRectangle extends Rectangle {
	public function new(x:Float, y:Float, width:Float, height:Float) {
		super(x, y, width, height);
	}
	
	static public function fromRectangle(rect:Rectangle):DRectangle {
		return new DRectangle(rect.x, rect.y, rect.width, rect.height);
	}

	/*
	public function toRectangle(ms:TScaling):Rectangle {
		return new Rectangle(this.x*ms.quarterNoteWidth, this.y*ms.halfSpace, this.width*ms.quarterNoteWidth, this.height*ms.halfSpace);
	}
	*/
	
}
	
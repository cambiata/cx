package nx3.elements;

/**
 * ...
 * @author 
 */
class EKey 
{
	static public var Sharp6 		= new EKey(6);
	static public var Sharp5 		= new EKey(5);
	static public var Sharp4 		= new EKey(4);
	static public var Sharp3 		= new EKey(3);
	static public var Sharp2 		= new EKey(2);
	static public var Sharp1 		= new EKey(1);
	static public var Natural 		= new EKey(0);
	static public var Flat1 		= new EKey(-1);
	static public var Flat2 		= new EKey(-2);
	static public var Flat3 		= new EKey(-3);
	static public var Flat4 		= new EKey(-4);
	static public var Flat5 		= new EKey(-5);
	static public var Flat6 		= new EKey(-6);
	
	public function new(levelShift:Int) {
		this.levelShift = levelShift;
	}
	public var levelShift:Int;
	
	static public function getSignLevel(levelShift:Int, signIndex:Int, clef:EClef) {
		var shift = [0];
		
		if (levelShift < 0) {
			shift = [0, -3, 1, -2, 2, -1, 3];
		} else {
			shift =  [ -4, -1, -5, -2, -6, -3];
		}
		
		var level = shift[signIndex];
		
		if (clef != null) {
			switch (clef) {
				case EClef.ClefC: level += 1;
				case EClef.ClefF: level += 2;
				default:
			}
		}
		
		if (level < -5) level += 7;
		
		return level;
		
		
	}
}

package nx.enums;
import nx.Constants;

/**
 * ...
 * @author Jonas Nyström
 */

class ENoteValue {
	static public var Nv1 		= new ENoteValue(setValue(4), EHeadType.Whole);
	static public var Nv1dot 	= new ENoteValue(setValue(4, true), EHeadType.Whole, 0, 0, 1);
	static public var Nv1tri 	= new ENoteValue(setValue(4, false, true), EHeadType.Whole);
	static public var Nv2 		= new ENoteValue(setValue(2), EHeadType.White, 1);
	static public var Nv2dot 	= new ENoteValue(setValue(2, true), EHeadType.White, 1, 0, 1);
	static public var Nv2tri 	= new ENoteValue(setValue(2, false, true), EHeadType.White, 1);
	static public var Nv4 		= new ENoteValue(setValue(1), EHeadType.Black, 1);
	static public var Nv4dot 	= new ENoteValue(setValue(1, true), EHeadType.Black, 1, 0, 1);
	static public var Nv4tri 	= new ENoteValue(setValue(1, false, true), EHeadType.Black, 1);
	static public var Nv4ddot	= new ENoteValue(setValue(1, false, false, true), EHeadType.Black, 1, 0, 2);
	static public var Nv8 		= new ENoteValue(setValue(.5), EHeadType.Black, 1, 1);
	static public var Nv8dot 	= new ENoteValue(setValue(.5, true), EHeadType.Black, 1, 1, 1);
	static public var Nv8tri 	= new ENoteValue(setValue(.5, false, true), EHeadType.Black, 1, 1);
	static public var Nv16 		= new ENoteValue(setValue(.25), EHeadType.Black, 1, 2);
	static public var Nv16dot 	= new ENoteValue(setValue(.25, true), EHeadType.Black, 1, 2, 1);
	static public var Nv16tri 	= new ENoteValue(setValue(.25, false, true), EHeadType.Black, 1, 2);
	
	public function new(value:Int, ?headType:EHeadType=null, ?stavingLevel:Int=0, ?beamingLevel:Int=0, ?dotlevel:Int=0) {
		this.value = value;
		this.headType = (headType == null) ? EHeadType.Black : headType;
		this.stavingLevel = stavingLevel;
		this.beamingLevel = beamingLevel;
		this.dotLevel = dotlevel;
	}
	public var headType:EHeadType;
	public var value:Int;
	public var stavingLevel:Int;
	public var beamingLevel:Int;
	public var dotLevel:Int;
	
	static private function setValue(to4:Float, ?dot:Bool, ?tri:Bool, ?ddot:Bool):Int {
		var val:Int = Std.int(to4 * Constants.BASE_NOTE_VALUE);
		if (dot) return Std.int(val * 1.5);
		if (tri) return Std.int((val / 3) * 2);
		if (ddot) return Std.int(val * 1.75);
		return val;
	}
	
	static public function get(value:Int) {
		switch(value) {
			case 16: return Nv16;
			case 8:return Nv8;
			case 2:return Nv2;
			default: return Nv4;
		}
	}
	
	static public function getFromValue(value:Int):ENoteValue {
		//trace (Reflect.fields(ENoteValue));
		//trace('get..');
		
		for (f in Reflect.fields(ENoteValue)) {
			
			if (StringTools.startsWith(f, 'Nv')) {

				//trace(f);
				
				var val = cast((Reflect.field(ENoteValue, f)), ENoteValue);
				//trace([val.value, value]);
				
				if (val.value == value) {
					return val; // cast(val, ENoteValue);
					break;
				}
				
			}
			
		}
		return ENoteValue.Nv4;
	}
}
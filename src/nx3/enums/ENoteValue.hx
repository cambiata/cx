package nx3.enums;
import nx3.units.Constants;

/**
 * ...
 * @author Jonas Nyström
 */

 class ENoteValue 
 {
	static public var Nv4 			= new ENoteValue(Constants.BASE_NOTE_VALUE);
	static public var Nv4dot 		= new ENoteValue(Constants.BASE_NOTE_VALUE * 1.5);
	static public var Nv4ddot 	= new ENoteValue(Constants.BASE_NOTE_VALUE * 1.75);
	static public var Nv4tri 		= new ENoteValue(Constants.BASE_NOTE_VALUE * (2/3));
	
	public var value(default, null):Int;
	public function new(value:Float)
	{
		this.value = Std.int(value);
	}
 }
 
 
 /*
using nx3.enums.ENoteValue.ENoteValueTools;
enum  ENoteValue
{
		Nv1;
		Nv1dot;
		Nv1ddot;
		Nv1tri;
		Nv2;
		Nv2dot;
		Nv2ddot;
		Nv2tri;
		Nv4;
		Nv4dot;
		Nv4ddot;
		Nv4tri;
		Nv8;
		Nv8dot;
		Nv8ddot;
		Nv8tri;
		Nv16;
		Nv16dot;
		Nv16ddot;
		Nv16tri;
}

class ENoteValueTools
{
	static public function value(noteValue:ENoteValue) 
	{
		return switch(noteValue)
		{
			case Nv1: 				Std.int(4 * Constants.BASE_NOTE_VALUE);		
			case Nv1dot: 		Std.int(4 * Constants.BASE_NOTE_VALUE * 1.5);		
			case Nv1ddot: 		Std.int(4 * Constants.BASE_NOTE_VALUE * 1.75);		
			case Nv1tri: 			Std.int(4 * Constants.BASE_NOTE_VALUE * (2/3));		
			default:  				Constants.BASE_NOTE_VALUE;
		}
	}
	
	
	
}
*/

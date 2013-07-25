package nx3.elements;
import nx3.elements.EHeadValuetype;
import nx3.units.Constants;

/**
 * ...
 * @author Jonas Nyström
 */

 class ENoteValue 
 {
	 static var DOT = 1.5;
	 static var DOTDOT = 1.75;
	 static var TRI = (2 / 3);

	 static var N1 = 4;
	 static var N2 = 2;
	 static var N8 = .5;
	 static var N16 = .25;
	 static var N32 = .125;
	 
	static public var Nv1 			= new ENoteValue(N1 * Constants.BASE_NOTE_VALUE,				EHeadValuetype.HVT1);
	static public var Nv1dot 		= new ENoteValue(N1 * Constants.BASE_NOTE_VALUE * DOT, 		EHeadValuetype.HVT1);
	static public var Nv1ddot 	= new ENoteValue(N1 * Constants.BASE_NOTE_VALUE * DOTDOT, 	EHeadValuetype.HVT1);
	static public var Nv1tri 		= new ENoteValue(N1 * Constants.BASE_NOTE_VALUE * TRI, 		EHeadValuetype.HVT1);	 
	 
	static public var Nv2 			= new ENoteValue(N2 * Constants.BASE_NOTE_VALUE,				EHeadValuetype.HVT2);
	static public var Nv2dot 		= new ENoteValue(N2 * Constants.BASE_NOTE_VALUE * DOT,		EHeadValuetype.HVT2);
	static public var Nv2ddot 	= new ENoteValue(N2 * Constants.BASE_NOTE_VALUE * DOTDOT,	EHeadValuetype.HVT2);
	static public var Nv2tri 		= new ENoteValue(N2 * Constants.BASE_NOTE_VALUE * TRI,			EHeadValuetype.HVT2);	 
	 
	static public var Nv4 			= new ENoteValue(Constants.BASE_NOTE_VALUE,					EHeadValuetype.HVT4);
	static public var Nv4dot 		= new ENoteValue(Constants.BASE_NOTE_VALUE * DOT,				EHeadValuetype.HVT4);
	static public var Nv4ddot 	= new ENoteValue(Constants.BASE_NOTE_VALUE * DOTDOT,		EHeadValuetype.HVT4);
	static public var Nv4tri 		= new ENoteValue(Constants.BASE_NOTE_VALUE * TRI,				EHeadValuetype.HVT4);

	static public var Nv8 			= new ENoteValue(N8 * Constants.BASE_NOTE_VALUE,				EHeadValuetype.HVT4);
	static public var Nv8dot 		= new ENoteValue(N8 * Constants.BASE_NOTE_VALUE * DOT,		EHeadValuetype.HVT4);
	static public var Nv8ddot 	= new ENoteValue(N8 * Constants.BASE_NOTE_VALUE * DOTDOT,	EHeadValuetype.HVT4);
	static public var Nv8tri 		= new ENoteValue(N8 * Constants.BASE_NOTE_VALUE * TRI,			EHeadValuetype.HVT4);
	
	static public var Nv16			= new ENoteValue(N16 * Constants.BASE_NOTE_VALUE,				EHeadValuetype.HVT4);
	static public var Nv16dot 	= new ENoteValue(N16 * Constants.BASE_NOTE_VALUE * DOT,		EHeadValuetype.HVT4);
	static public var Nv16ddot 	= new ENoteValue(N16 * Constants.BASE_NOTE_VALUE * DOTDOT,	EHeadValuetype.HVT4);
	static public var Nv16tri 		= new ENoteValue(N16 * Constants.BASE_NOTE_VALUE * TRI,		EHeadValuetype.HVT4);
	
	static public var Nv32			= new ENoteValue(N32 * Constants.BASE_NOTE_VALUE,				EHeadValuetype.HVT4);
	static public var Nv32dot 	= new ENoteValue(N32 * Constants.BASE_NOTE_VALUE * DOT,		EHeadValuetype.HVT4);
	static public var Nv32ddot 	= new ENoteValue(N32 * Constants.BASE_NOTE_VALUE * DOTDOT,	EHeadValuetype.HVT4);
	static public var Nv32tri 		= new ENoteValue(N32 * Constants.BASE_NOTE_VALUE * TRI,		EHeadValuetype.HVT4);
	
	
	public var value(default, null):Int;
	public var type(default, null):EHeadValuetype;
	private function new(value:Float, type:EHeadValuetype)
	{
		this.value = Std.int(value);
		this.type = type;
	}
	
	static public function getFromValue(value:Int)
	{
		
		if (value == N1 * Constants.BASE_NOTE_VALUE) 				return ENoteValue.Nv1;
		if (value == N1 * Constants.BASE_NOTE_VALUE * DOT) 		return ENoteValue.Nv1dot;
		if (value == N1 * Constants.BASE_NOTE_VALUE * DOTDOT)	return ENoteValue.Nv1ddot;
		if (value == N1 * Constants.BASE_NOTE_VALUE * TRI) 			return ENoteValue.Nv1tri;
		
		if (value == N2 * Constants.BASE_NOTE_VALUE) 				return ENoteValue.Nv2;
		if (value == N2 * Constants.BASE_NOTE_VALUE * DOT) 		return ENoteValue.Nv2dot;
		if (value == N2 * Constants.BASE_NOTE_VALUE * DOTDOT)	return ENoteValue.Nv2ddot;
		if (value == N2 * Constants.BASE_NOTE_VALUE * TRI) 			return ENoteValue.Nv2tri;		
		
		if (value == Constants.BASE_NOTE_VALUE) 					return ENoteValue.Nv4;
		if (value == Constants.BASE_NOTE_VALUE * DOT) 				return ENoteValue.Nv4dot;
		if (value == Constants.BASE_NOTE_VALUE * DOTDOT)			return ENoteValue.Nv4ddot;
		if (value == Constants.BASE_NOTE_VALUE * TRI) 				return ENoteValue.Nv4tri;
		
		if (value == N8 * Constants.BASE_NOTE_VALUE) 				return ENoteValue.Nv8;
		if (value == N8 * Constants.BASE_NOTE_VALUE * DOT) 		return ENoteValue.Nv8dot;
		if (value == N8 * Constants.BASE_NOTE_VALUE * DOTDOT)	return ENoteValue.Nv8ddot;
		if (value == N8 * Constants.BASE_NOTE_VALUE * TRI) 			return ENoteValue.Nv8tri;
		
		if (value == N16 * Constants.BASE_NOTE_VALUE) 				return ENoteValue.Nv16;
		if (value == N16 * Constants.BASE_NOTE_VALUE * DOT) 		return ENoteValue.Nv16dot;
		if (value == N16 * Constants.BASE_NOTE_VALUE * DOTDOT)	return ENoteValue.Nv16ddot;
		if (value == N16 * Constants.BASE_NOTE_VALUE * TRI) 		return ENoteValue.Nv16tri;
		
		if (value == N32 * Constants.BASE_NOTE_VALUE) 				return ENoteValue.Nv32;
		if (value == N32 * Constants.BASE_NOTE_VALUE * DOT) 		return ENoteValue.Nv32dot;
		if (value == N32 * Constants.BASE_NOTE_VALUE * DOTDOT)	return ENoteValue.Nv32ddot;
		if (value == N32 * Constants.BASE_NOTE_VALUE * TRI) 		return ENoteValue.Nv32tri;
		
		throw 'Could not find note value for value $value';
		return ENoteValue.Nv4;
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

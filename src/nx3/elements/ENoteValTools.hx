package nx3.elements;
import haxe.macro.Context;
import nx3.Constants;

/**
 * ...
 * @author Jonas Nyström
 */

 
class ENoteValTools
{
	 static inline var DOT = 1.5;
	 static inline var DOTDOT = 1.75;
	 static inline  var TRI = 0.66666666; // (2 / 3);

	 static inline var N1 = 4;
	 static inline var N2 = 2;
	 static inline var N4 = 1;
	 static inline var N8 = .5;
	 static inline var N16 = .25;
	 static inline var N32 = .125;	
	 
	static inline var valNv1:Int = Std.int(N1 * Constants.BASE_NOTE_VALUE ) ;
	static inline var valNv1dot:Int = Std.int(N1 * Constants.BASE_NOTE_VALUE*DOT ) ;
	static inline var valNv1ddot:Int = Std.int(N1 * Constants.BASE_NOTE_VALUE*DOTDOT ) ;
	static inline var valNv1tri:Int = Std.int(N1 * Constants.BASE_NOTE_VALUE * TRI ) ;
	
	static inline var valNv2:Int = Std.int(N2 * Constants.BASE_NOTE_VALUE ) ;
	static inline var valNv2dot:Int = Std.int(N2 * Constants.BASE_NOTE_VALUE*DOT ) ;
	static inline var valNv2ddot:Int = Std.int(N2 * Constants.BASE_NOTE_VALUE*DOTDOT ) ;
	static inline var valNv2tri:Int = Std.int(N2 * Constants.BASE_NOTE_VALUE *TRI) ;
	
	static inline var valNv4:Int = Std.int(N4 * Constants.BASE_NOTE_VALUE ) ;
	static inline var valNv4dot:Int = Std.int(N4 * Constants.BASE_NOTE_VALUE*DOT ) ;
	static inline var valNv4ddot:Int = Std.int(N4 * Constants.BASE_NOTE_VALUE*DOTDOT ) ;
	static inline var valNv4tri:Int = Std.int(N4 * Constants.BASE_NOTE_VALUE *TRI) ;
	
	static inline var valNv8:Int = Std.int(N8 * Constants.BASE_NOTE_VALUE ) ;
	static inline var valNv8dot:Int = Std.int(N8 * Constants.BASE_NOTE_VALUE*DOT ) ;
	static inline var valNv8ddot:Int = Std.int(N8 * Constants.BASE_NOTE_VALUE*DOTDOT ) ;
	static inline var valNv8tri:Int = Std.int(N8 * Constants.BASE_NOTE_VALUE *TRI) ;
	
	static inline var valNv16:Int = Std.int(N16 * Constants.BASE_NOTE_VALUE ) ;
	static inline var valNv16dot:Int = Std.int(N16 * Constants.BASE_NOTE_VALUE*DOT ) ;
	static inline var valNv16ddot:Int = Std.int(N16 * Constants.BASE_NOTE_VALUE*DOTDOT ) ;
	static inline var valNv16tri:Int = Std.int(N16 * Constants.BASE_NOTE_VALUE *TRI) ;
	
	static inline var valNv32:Int = Std.int(N32 * Constants.BASE_NOTE_VALUE ) ;
	static inline var valNv32dot:Int = Std.int(N32 * Constants.BASE_NOTE_VALUE*DOT ) ;
	static inline var valNv32ddot:Int = Std.int(N32 * Constants.BASE_NOTE_VALUE*DOTDOT ) ;
	static inline var valNv32tri:Int = Std.int(N32 * Constants.BASE_NOTE_VALUE *TRI) ;

	 
	 static public function beaminglevel(val:ENoteVal)
	 {
		 return switch val
		 {
			case ENoteVal.Nv8:  1;
			case ENoteVal.Nv8tri: 1;
			case ENoteVal.Nv8dot: 1;
			case ENoteVal.Nv8ddot:  1;
			case ENoteVal.Nv16:  2;
			case ENoteVal.Nv16tri: 2;
			case ENoteVal.Nv16dot: 2;
			case ENoteVal.Nv16ddot:  2;
			case ENoteVal.Nv32:  3;
			case ENoteVal.Nv32tri:  3;
			case ENoteVal.Nv32dot:  3;
			case ENoteVal.Nv32ddot:   3;
			default: 0;
			//	return 0;
		 }
	 }
	 
	 static public function stavinglevel(val:ENoteVal)
	 {
		 return switch val
		 {
			case ENoteVal.Nv1:  0;
			case ENoteVal.Nv1tri: 0;
			case ENoteVal.Nv1dot: 0;
			case ENoteVal.Nv1ddot:  0;
			 default : 1;
		 }
	 }
	 
	 static public function head(val:ENoteVal)
	 {
		return switch val
		 {
			case ENoteVal.Nv1:  EHeadValuetype.HVT1;
			case ENoteVal.Nv1tri: EHeadValuetype.HVT1;
			case ENoteVal.Nv1dot: EHeadValuetype.HVT1;
			case ENoteVal.Nv1ddot:  EHeadValuetype.HVT1;
				
			case ENoteVal.Nv2:  EHeadValuetype.HVT2;
			case ENoteVal.Nv2tri:  EHeadValuetype.HVT2;
			case ENoteVal.Nv2dot:  EHeadValuetype.HVT2;
			case ENoteVal.Nv2ddot:   EHeadValuetype.HVT2;
			default:  EHeadValuetype.HVT4;
		 }
	 }
	 
	static public function value(noteval:ENoteVal) 
	{
		return switch noteval
		{
			case Nv1:  valNv1;
			case Nv1dot:  valNv1dot;
			case Nv1ddot:  valNv1ddot;
			case Nv1tri:  valNv1tri;

			case Nv2:  valNv2;
			case Nv2dot:  valNv2dot;
			case Nv2ddot:  valNv2ddot;
			case Nv2tri:  valNv2tri;

			case Nv4:  valNv4;
			case Nv4dot:  valNv4dot;
			case Nv4ddot:  valNv4ddot;
			case Nv4tri:  valNv4tri;

			case Nv8:  valNv8;
			case Nv8dot:  valNv8dot;
			case Nv8ddot:  valNv8ddot;
			case Nv8tri:  valNv8tri;

			case Nv16:  valNv16;
			case Nv16dot:  valNv16dot;
			case Nv16ddot:  valNv16ddot;
			case Nv16tri:  valNv16tri;

			case Nv32:  valNv32;
			case Nv32dot:  valNv32dot;
			case Nv32ddot:  valNv32ddot;
			case Nv32tri:  valNv32tri;
		}
	}
	
	static public function getFromValue(value:Int):ENoteVal
	{
		return	switch value
		{
			case valNv1:  ENoteVal.Nv1;
			case valNv1dot:  ENoteVal.Nv1dot;
			case valNv1ddot:  ENoteVal.Nv1ddot;
			case valNv1tri:  ENoteVal.Nv1tri;
			case valNv2:  ENoteVal.Nv2;
			case valNv2dot:  ENoteVal.Nv2dot;
			case valNv2ddot:  ENoteVal.Nv2ddot;
			case valNv2tri:  ENoteVal.Nv2tri;
			case valNv4:  ENoteVal.Nv4;
			case valNv4dot:  ENoteVal.Nv4dot;
			case valNv4ddot:  ENoteVal.Nv4ddot;
			case valNv4tri:  ENoteVal.Nv4tri;
			case valNv8:  ENoteVal.Nv8;
			case valNv8dot:  ENoteVal.Nv8dot;
			case valNv8ddot:  ENoteVal.Nv8ddot;
			case valNv8tri:  ENoteVal.Nv8tri;
			case valNv16:  ENoteVal.Nv16;
			case valNv16dot:  ENoteVal.Nv16dot;
			case valNv16ddot:  ENoteVal.Nv16ddot;
			case valNv16tri:  ENoteVal.Nv16tri;
			case valNv32:  ENoteVal.Nv32;
			case valNv32dot:  ENoteVal.Nv32dot;
			case valNv32ddot:  ENoteVal.Nv32ddot;
			case valNv32tri:  ENoteVal.Nv32tri;
			
		default: null;
			
		}
		
	}
	
}
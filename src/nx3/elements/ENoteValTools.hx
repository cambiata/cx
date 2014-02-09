package nx3.elements;
import cx.FileTools;
import haxe.macro.Context;
import nx3.Constants;

/**
 * ...
 * @author Jonas Nyström
 */

 /*
enum EHeadValType 
{
	HVT4;		// fourth
	HVT2;		// halv
	HVT1;		// whole
}
 */
 
 
class ENoteValTools
{
	 static var DOT = 1.5;
	 static var DOTDOT = 1.75;
	 static var TRI = (2 / 3);

	 static var N1 = 4;
	 static var N2 = 2;
	 static var N4 = 1;
	 static var N8 = .5;
	 static var N16 = .25;
	 static var N32 = .125;	
	 

	 
	 static public function beaminglevel(val:ENoteVal)
	 {
		  switch val
		 {
			case ENoteVal.Nv8: return 1;
			case ENoteVal.Nv8tri:return 1;
			case ENoteVal.Nv8dot:return 1;
			case ENoteVal.Nv8ddot: return 1;
			case ENoteVal.Nv16: return 2;
			case ENoteVal.Nv16tri:return 2;
			case ENoteVal.Nv16dot:return 2;
			case ENoteVal.Nv16ddot: return 2;
			case ENoteVal.Nv32: return 3;
			case ENoteVal.Nv32tri: return 3;
			case ENoteVal.Nv32dot: return 3;
			case ENoteVal.Nv32ddot:  return 3;
			default:
				return 0;
		 }
	 }
	 
	 static public function stavinglevel(val:ENoteVal)
	 {
		 switch val
		 {
			case ENoteVal.Nv1: return 0;
			case ENoteVal.Nv1tri:return 0;
			case ENoteVal.Nv1dot:return 0;
			case ENoteVal.Nv1ddot: return 0;
			 default : 
				 return 1;
		 }
	 }
	 
	 static public function head(val:ENoteVal)
	 {
		 switch val
		 {
			case ENoteVal.Nv1: return EHeadValuetype.HVT1;
			case ENoteVal.Nv1tri:return EHeadValuetype.HVT1;
			case ENoteVal.Nv1dot:return EHeadValuetype.HVT1;
			case ENoteVal.Nv1ddot: return EHeadValuetype.HVT1;
				
			case ENoteVal.Nv2: return EHeadValuetype.HVT2;
			case ENoteVal.Nv2tri: return EHeadValuetype.HVT2;
			case ENoteVal.Nv2dot: return EHeadValuetype.HVT2;
			case ENoteVal.Nv2ddot:  return EHeadValuetype.HVT2;
			default: 
				return EHeadValuetype.HVT4;
		 }
	 }
	 
	static public function value(val:ENoteVal) 
	{
	
		
		switch val
		{
	case Nv1: return Std.int(N1* Constants.BASE_NOTE_VALUE );
	case Nv1dot: return Std.int(N1* Constants.BASE_NOTE_VALUE * DOT);
	case Nv1ddot: return Std.int(N1* Constants.BASE_NOTE_VALUE * DOTDOT);
	case Nv1tri: return Std.int(N1* Constants.BASE_NOTE_VALUE * TRI);

	case Nv2: return Std.int(N2* Constants.BASE_NOTE_VALUE );
	case Nv2dot: return Std.int(N2* Constants.BASE_NOTE_VALUE * DOT);
	case Nv2ddot: return Std.int(N2* Constants.BASE_NOTE_VALUE * DOTDOT);
	case Nv2tri: return Std.int(N2* Constants.BASE_NOTE_VALUE * TRI);
	
	case Nv4: return Std.int(N4* Constants.BASE_NOTE_VALUE );
	case Nv4dot: return Std.int(N4* Constants.BASE_NOTE_VALUE * DOT);
	case Nv4ddot: return Std.int(N4* Constants.BASE_NOTE_VALUE * DOTDOT);
	case Nv4tri: return Std.int(N4* Constants.BASE_NOTE_VALUE * TRI);
		
	case 	Nv8: return Std.int(N8* Constants.BASE_NOTE_VALUE );
	case 	Nv8dot: return Std.int(N8* Constants.BASE_NOTE_VALUE * DOT);
	case 	Nv8ddot: return Std.int(N8* Constants.BASE_NOTE_VALUE * DOTDOT);
	case 	Nv8tri: return Std.int(N8* Constants.BASE_NOTE_VALUE * TRI);
		
	case 	Nv16: return Std.int(N16* Constants.BASE_NOTE_VALUE );
	case Nv16dot: return Std.int(N16* Constants.BASE_NOTE_VALUE * DOT);
	case Nv16ddot: return Std.int(N16* Constants.BASE_NOTE_VALUE * DOTDOT);
	case Nv16tri: return Std.int(N16* Constants.BASE_NOTE_VALUE * TRI);
	
	case Nv32: return Std.int(N32* Constants.BASE_NOTE_VALUE );
	case Nv32dot: return Std.int(N32* Constants.BASE_NOTE_VALUE * DOT);
	case Nv32ddot: return Std.int(N32* Constants.BASE_NOTE_VALUE * DOTDOT);
	case Nv32tri: return Std.int(N32* Constants.BASE_NOTE_VALUE * TRI);			
		}
	}
	
	static public function getFromValue(value:Int):ENoteVal
	{
		/*
		str = '';
		str += '\t\tstatic public inline var valNv1:Int = ' +  Std.int(N1 * Constants.BASE_NOTE_VALUE ) + ';\n';
		str += '\t\tstatic public inline var valNv1dot:Int = ' +  Std.int(N1 * Constants.BASE_NOTE_VALUE*DOT ) + ';\n';
		str += '\t\tstatic public inline var valNv1ddot:Int = ' +  Std.int(N1 * Constants.BASE_NOTE_VALUE*DOTDOT ) + ';\n';
		str += '\t\tstatic public inline var valNv1tri:Int = ' +  Std.int(N1 * Constants.BASE_NOTE_VALUE*TRI ) + ';\n';
		str += '\t\tstatic public inline var valNv2:Int = ' +  Std.int(N2 * Constants.BASE_NOTE_VALUE ) + ';\n';
		str += '\t\tstatic public inline var valNv2dot:Int = ' +  Std.int(N2 * Constants.BASE_NOTE_VALUE*DOT ) + ';\n';
		str += '\t\tstatic public inline var valNv2ddot:Int = ' +  Std.int(N2 * Constants.BASE_NOTE_VALUE*DOTDOT ) + ';\n';
		str += '\t\tstatic public inline var valNv2tri:Int = ' +  Std.int(N2 * Constants.BASE_NOTE_VALUE * TRI ) + ';\n';
		str += '\t\tstatic public inline var valNv4:Int = ' +  Std.int(N4 * Constants.BASE_NOTE_VALUE ) + ';\n';
		str += '\t\tstatic public inline var valNv4dot:Int = ' +  Std.int(N4 * Constants.BASE_NOTE_VALUE*DOT ) + ';\n';
		str += '\t\tstatic public inline var valNv4ddot:Int = ' +  Std.int(N4 * Constants.BASE_NOTE_VALUE*DOTDOT ) + ';\n';
		str += '\t\tstatic public inline var valNv4tri:Int = ' +  Std.int(N4 * Constants.BASE_NOTE_VALUE * TRI ) + ';\n';
		str += '\t\tstatic public inline var valNv8:Int = ' +  Std.int(N8 * Constants.BASE_NOTE_VALUE ) + ';\n';
		str += '\t\tstatic public inline var valNv8dot:Int = ' +  Std.int(N8 * Constants.BASE_NOTE_VALUE*DOT ) + ';\n';
		str += '\t\tstatic public inline var valNv8ddot:Int = ' +  Std.int(N8 * Constants.BASE_NOTE_VALUE*DOTDOT ) + ';\n';
		str += '\t\tstatic public inline var valNv8tri:Int = ' +  Std.int(N8 * Constants.BASE_NOTE_VALUE * TRI ) + ';\n';
		str += '\t\tstatic public inline var valNv16:Int = ' +  Std.int(N16 * Constants.BASE_NOTE_VALUE ) + ';\n';
		str += '\t\tstatic public inline var valNv16dot:Int = ' +  Std.int(N16 * Constants.BASE_NOTE_VALUE*DOT ) + ';\n';
		str += '\t\tstatic public inline var valNv16ddot:Int = ' +  Std.int(N16 * Constants.BASE_NOTE_VALUE*DOTDOT ) + ';\n';
		str += '\t\tstatic public inline var valNv16tri:Int = ' +  Std.int(N16 * Constants.BASE_NOTE_VALUE * TRI ) + ';\n';
		str += '\t\tstatic public inline var valNv32:Int = ' +  Std.int(N32 * Constants.BASE_NOTE_VALUE ) + ';\n';
		str += '\t\tstatic public inline var valNv32dot:Int = ' +  Std.int(N32 * Constants.BASE_NOTE_VALUE*DOT ) + ';\n';
		str += '\t\tstatic public inline var valNv32ddot:Int = ' +  Std.int(N32 * Constants.BASE_NOTE_VALUE*DOTDOT ) + ';\n';
		str += '\t\tstatic public inline var valNv32tri:Int = ' +  Std.int(N32 * Constants.BASE_NOTE_VALUE * TRI ) + ';\n';
		str += '\n';
		str += 'case valNv1: return ENoteVal.Nv1;\n';
		str += 'case valNv1dot: return ENoteVal.Nv1dot;\n';
		str += 'case valNv1ddot: return ENoteVal.Nv1ddot;\n';
		str += 'case valNv1tri: return ENoteVal.Nv1tri;\n';

		str += 'case valNv2: return ENoteVal.Nv2;\n';
		str += 'case valNv2dot: return ENoteVal.Nv2dot;\n';
		str += 'case valNv2ddot: return ENoteVal.Nv2ddot;\n';
		str += 'case valNv2tri: return ENoteVal.Nv2tri;\n';		
		
		str += 'case valNv4: return ENoteVal.Nv4;\n';
		str += 'case valNv4dot: return ENoteVal.Nv4dot;\n';
		str += 'case valNv4ddot: return ENoteVal.Nv4ddot;\n';
		str += 'case valNv4tri: return ENoteVal.Nv4tri;\n';
		
		str += 'case valNv8: return ENoteVal.Nv8;\n';
		str += 'case valNv8dot: return ENoteVal.Nv8dot;\n';
		str += 'case valNv8ddot: return ENoteVal.Nv8ddot;\n';
		str += 'case valNv8tri: return ENoteVal.Nv8tri;\n';
		
		str += 'case valNv16: return ENoteVal.Nv16;\n';
		str += 'case valNv16dot: return ENoteVal.Nv16dot;\n';
		str += 'case valNv16ddot: return ENoteVal.Nv16ddot;\n';
		str += 'case valNv16tri: return ENoteVal.Nv16tri;\n';
		
		str += 'case valNv32: return ENoteVal.Nv32;\n';
		str += 'case valNv32dot: return ENoteVal.Nv32dot;\n';
		str += 'case valNv32ddot: return ENoteVal.Nv32ddot;\n';
		str += 'case valNv32tri: return ENoteVal.Nv32tri;\n';

		
		
		
		FileTools.putContent('val.txt', str);
		*/

		switch (value)
		{
			
			case valNv1: return ENoteVal.Nv1;
			case valNv1dot: return ENoteVal.Nv1dot;
			case valNv1ddot: return ENoteVal.Nv1ddot;
			case valNv1tri: return ENoteVal.Nv1tri;
			case valNv2: return ENoteVal.Nv2;
			case valNv2dot: return ENoteVal.Nv2dot;
			case valNv2ddot: return ENoteVal.Nv2ddot;
			case valNv2tri: return ENoteVal.Nv2tri;
			case valNv4: return ENoteVal.Nv4;
			case valNv4dot: return ENoteVal.Nv4dot;
			case valNv4ddot: return ENoteVal.Nv4ddot;
			case valNv4tri: return ENoteVal.Nv4tri;
			case valNv8: return ENoteVal.Nv8;
			case valNv8dot: return ENoteVal.Nv8dot;
			case valNv8ddot: return ENoteVal.Nv8ddot;
			case valNv8tri: return ENoteVal.Nv8tri;
			case valNv16: return ENoteVal.Nv16;
			case valNv16dot: return ENoteVal.Nv16dot;
			case valNv16ddot: return ENoteVal.Nv16ddot;
			case valNv16tri: return ENoteVal.Nv16tri;
			case valNv32: return ENoteVal.Nv32;
			case valNv32dot: return ENoteVal.Nv32dot;
			case valNv32ddot: return ENoteVal.Nv32ddot;
			case valNv32tri: return ENoteVal.Nv32tri;
			
			default: //
		}
		return ENoteVal.Nv4;
	}
	
		static public inline var valNv1:Int = 12096;
		static public inline var valNv1dot:Int = 18144;
		static public inline var valNv1ddot:Int = 21168;
		static public inline var valNv1tri:Int = 8064;
		static public inline var valNv2:Int = 6048;
		static public inline var valNv2dot:Int = 9072;
		static public inline var valNv2ddot:Int = 10584;
		static public inline var valNv2tri:Int = 4032;
		static public inline var valNv4:Int = 3024;
		static public inline var valNv4dot:Int = 4536;
		static public inline var valNv4ddot:Int = 5292;
		static public inline var valNv4tri:Int = 2016;
		static public inline var valNv8:Int = 1512;
		static public inline var valNv8dot:Int = 2268;
		static public inline var valNv8ddot:Int = 2646;
		static public inline var valNv8tri:Int = 1008;
		static public inline var valNv16:Int = 756;
		static public inline var valNv16dot:Int = 1134;
		static public inline var valNv16ddot:Int = 1323;
		static public inline var valNv16tri:Int = 504;
		static public inline var valNv32:Int = 378;
		static public inline var valNv32dot:Int = 567;
		static public inline var valNv32ddot:Int = 661;
		static public inline var valNv32tri:Int = 252;
	
	
}
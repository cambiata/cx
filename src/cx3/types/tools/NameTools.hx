package cx3.types.tools;

/**
 * ...
 * @author Jonas Nyström
 */

using StringTools;
using cx3.types.tools.NameTools;
class NameTools
{
	static public inline function adjLastname(s:String):String {
		var bprefs = ['de la ', 'von ', 'af ', 'de ', 'Mc', "O'", 'deLa '];
		var pref = '';
		for (bpref in bprefs) {
			if (s.toLowerCase().startsWith(bpref.toLowerCase())) {				
				pref = bpref; // namn.substr(0, bpref.length);
				s = s.substr(bpref.length);
			}		
		}
		s = s.adjName();
		return pref + s;				
	}
	
	static public inline function adjName(s:String):String {
		s = s.trim();
		s = s.replace('  ', ' ');
		s = s.replace('   ', ' ');
		var segments = [s];
		var bs = s.indexOf('-');
		if (bs > -1) segments = s.split('-');
		var sp = -1;
		if (bs == -1) {
			sp = s.indexOf(' ');
			if (sp > -1) segments = s.split(' ');		
		}
		var segments = Lambda.map(segments, function(segment) {
			return segment.adjNameSegment();
		});		
		if (bs > -1) return segments.join('-') 
		else if (sp > -1) return segments.join(' ') else
		return segments.first();				
	}
	
	static public inline function adjNameSegment(s:String):String {	
		s = s.trim();
		s = s.removeForbiddenChars();
		s = s.charAt(0).toUpperCase() + s.substr(1).toLowerCase(); 
		return s;
	}

	static public inline function removeForbiddenChars(s:String):String {
		s = s.replace('  ', ' ');
		var forbiddens = '§½€~^¨|!"#¤%&/()?@£$+*\\<>1234567890()[]{}´`'.split('');		
		for (forbidden in forbiddens) {		
			if (s.indexOf(forbidden) > -1) {				
				s = s.replace(forbidden, '');		
			}
		}
		s = s.replace('=', '-');
		s = s.replace('_', '-');
		return s;
	}
	
}
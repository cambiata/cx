package cx;


/**
 * ...
 * @author Jonas Nyström
 */

class ValidationTools {
	
	static public function isValidEmail( email : String ) : Bool {
		if (email == null) return false;
		var emailExpression : EReg = ~/^[\w-\.]{2,}@[ÅÄÖåäö\w-\.]{2,}\.[a-z]{2,6}$/i;
		return emailExpression.match( email );
	}	
	
	static public function isValidPersonnrLong( personnr: String ) : Bool {
		if (personnr == null) return false;
		if (personnr.charAt(8) != '-') return false;
		var segments = personnr.split('-');
		if (segments[0].length != 8) return false;
		if (segments[1].length != 4) return false;
		if (Std.parseInt(segments[0]) == null) return false;
		if (Std.parseInt(segments[1]) == null) return false;
		return true;
	}
	
}
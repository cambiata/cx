package cx;


/**
 * ...
 * @author Jonas Nyström
 */

class ValidationTools {
	
	static public function isValidEmail( email : String ) : Bool
	{
		var emailExpression : EReg = ~/^[\w-\.]{2,}@[ÅÄÖåäö\w-\.]{2,}\.[a-z]{2,6}$/i;
		return emailExpression.match( email );
	}	
	
}
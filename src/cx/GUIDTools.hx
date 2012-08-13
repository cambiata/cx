package cx;

/**
 * ...
 * @author Jonas Nyström
 */

class GUIDTools 
{

	/*
	 * *********************************************************
	 * CONSTRUCTOR
	 * *********************************************************
	 *
	*/

	
	static public function guid() {
		var result = "";

		for (j in 0...32) {
		  if ( j == 8 || j == 12|| j == 16|| j == 20) {
			result += "-";
		  }

		  result += StringTools.hex(Math.floor(Math.random()*16));
		}

		return result.toUpperCase();
	}
	
	/*
	 * *********************************************************
	 * 
	 * *********************************************************
	 *
	*/	
	

	
}
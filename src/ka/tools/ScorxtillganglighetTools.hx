package ka.tools;
import cx.ArrayTools;
import cx.Tools;
import ka.types.Scorxtillgangligheter;

/**
 * ...
 * @author Jonas Nyström
 */

class ScorxtillganglighetTools 
{
	static public function getTillganglighet(tillg:Scorxtillgangligheter, roll:String, kor:String='', individ:String='') {
		
		var uniqueTillg = new Array<String>();
		
		for (till in tillg) {			
			if (till.kategori == roll) {
				uniqueTillg = uniqueTillg.concat(till.mappar);				
			}
			
			if (till.kategori == kor) {
				uniqueTillg = uniqueTillg.concat(till.mappar);				
			}
						
			if (till.kategori == individ) {
				uniqueTillg = uniqueTillg.concat(till.mappar);								
			}
		}
		
		uniqueTillg = ArrayTools.unique(uniqueTillg);
		uniqueTillg.sort(function(a, b) { return Reflect.compare(a, b); } );
		return uniqueTillg;
	}
	
	
}
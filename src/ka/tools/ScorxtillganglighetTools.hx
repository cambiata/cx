package ka.tools;
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
		return Tools.arrayStringUnique(uniqueTillg, true);
	}
	
	
}
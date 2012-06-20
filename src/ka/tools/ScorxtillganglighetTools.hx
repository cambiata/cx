package ka.tools;
import cx.ArrayTools;
import cx.StrTools;
import cx.Tools;
import ka.types.Personer;
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
	
	static public function toAuthfile(filename:String, personer:Personer, scorxTillg:Scorxtillgangligheter) {		
		var f = neko.io.File.write(filename, false);
		//f.writeString('----------------------------------------------------------------------------\n');
		for (person in personer) {
			var tillg = ScorxtillganglighetTools.getTillganglighet(scorxTillg, person.roll, person.kor, person.personnr );
			var tillgStr = tillg.join(',');			
			var a = [person.epost, person.xpass, person.efternamn, person.fornamn, person.roll, StrTools.replaceNull(person.kor), tillgStr];			
			var str = a.join('|') + '\n';
			f.writeString(str);			
		}
		f.close();			
	}	
	
	
	
}
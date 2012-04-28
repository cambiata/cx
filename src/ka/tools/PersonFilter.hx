package ka.tools;

import ka.types.Admingrupper;
import ka.types.Korer;
import ka.types.Personer;
import ka.types.Studieterminer;

/**
 * ...
 * @author Jonas Nyström
 */

class PersonerFilter
{	
	static public function filterStudieterminer(personer:Personer, terminer:Studieterminer):Personer {
		var tempPersoner = new Personer(); 
		for (person in personer) {
			for (termin in terminer) {
				if (Lambda.has(person.studieterminer, termin)) tempPersoner.push(person);			
			}			
		}
		return tempPersoner;
	}	
	
	static public function filterKorer(personer:Personer, korer:Korer):Personer {
		var tempPersoner = new Personer(); 
		for (person in personer) {			
			if (person.kor == null) continue;
			for (kor in korer) {
				if (person.kor == kor.namn) {
					tempPersoner.push(person);
					break;
				}
			}
		}
		return tempPersoner;		
	}
	
	static public function filterAdmingrupper(personer:Personer, admingrupper:Admingrupper):Personer {
		var tempPersoner = new Personer(); 
		for (person in personer) {
			if (person.admgrupp == null) continue;
			for (admingrupp in admingrupper) {
				if (person.admgrupp == admingrupp.gruppnamn) {
					tempPersoner.push(person);
					break;
				}
			}
		}
		return tempPersoner;				
	}
}
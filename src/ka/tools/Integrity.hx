package ka.tools;
import cx.Tools;
import ka.types.Admingrupper;
import ka.types.Korer;
import ka.types.Person;
import ka.types.Personer;
import ka.types.StudieterminerExt;

/**
 * ...
 * @author Jonas Nyström
 */

class Integrity 
{
	static private var aLan = [
		'Blekinge län',
		'Dalarnas län',
		'Gotlands län',
		'Gävleborgs län',
		'Hallands län',
		'Jämtlands län',
		'Jönköpings län',
		'Kalmar län',
		'Kronobergs län',
		'Norrbottens län',
		'Skåne län',
		'Stockholms län',
		'Södermanlands län',
		'Uppsala län',
		'Värmlands län',
		'Västerbottens län',
		'Västernorrlands län',
		'Västmanlands län',
		'Västra Götalands län',
		'Örebro län',
		'Östergötlands län',
	];
	
	static private var aRoles = [
		'deltagare',
		'ledare',
		'administratör',
		'grupp',
	];
	
	
	static private var errors:IntegrityErrors;
	
	static public function check(personer:Personer, studieterminerExt:StudieterminerExt, admingrupper:Admingrupper, korer:Korer) {			
		
		errors = new IntegrityErrors();				
		if (personer != null) checkPersoner(personer);		
		if (studieterminerExt != null) checkStudieterminerExt(studieterminerExt);
		if (admingrupper != null) checkAdmingrupper(admingrupper);
		if (korer != null) checkKorer(korer);		
		
		if ((personer != null) && (studieterminerExt != null)) {
			checkPersonerStudieterminer(personer, studieterminerExt);
		}
		
		if ((personer != null) && (admingrupper != null)) {
			checkPersonerAdmingrupper(personer, admingrupper);
		}

		if ((personer != null) && (korer != null)) {
			checkPersonerKorer(personer, korer);
		}		
		
		
		return errors;
	}
	
	
	//-----------------------------------------------------------------------------------------------------
	
	static private function addError(type:String, id:String, msg:String) {
		var error:IntegrityError = { type:type, id:id, msg:msg };
		errors.push(error);
	}

	//-----------------------------------------------------------------------------------------------------
	
	static private function checkStudieterminerExt(str:StudieterminerExt) {
		for (st in str) {
			validStringLength('Studietermin/Name/Length', st.namn, st.namn, 5);
			
			try {
				validDate('Studietermin/Start/Valid-date', st.namn, st.start.toString());				
			} catch (e:Dynamic) {
				addError('Studietermin/Start/Valid-date', st.namn, 'date error');
			}
			
			try {
				validDate('Studietermin/Slut/Valid-date', st.namn, st.slut.toString());
			} catch (e:Dynamic) {
				addError('Studietermin/Slut/Valid-date', st.namn, 'date error');
			}			
			
		}
	}

	static private function checkPersoner(prs:Personer) {
		for (p in prs) {
			var id = p.efternamn + ', ' + p.fornamn + ' (' + p.personnr + ')';
			validStringLength('Person/Fornamn/Length', id, 		p.fornamn, 2);			
			validFirstUppercase('Person/Fornamn/Uppercase', id, p.fornamn);
			validStringLength('Person/Efternamn/Length', id, 	p.efternamn, 2);
			validFirstUppercase('Person/Efternamn/Uppercase', id, p.efternamn, 'von ,de la ,af ');
			validEmail('Person/Email/Valid', id, 				p.epost);
			validPersonnummer('Person/Personnummer', id, 		p.personnr);
			validLan('Person/Lan', id,							p.lan);
			validInArray('Person/Roll', id, 					p.roll, aRoles);
		}
	}
	
	static private function checkAdmingrupper(admgr:Admingrupper) {
		for (a in admgr) {
			
		}
	}
	
	static private function checkKorer(korer:Korer) {
		for (k in korer) {
			
		}
	}
	
	static private function checkPersonerStudieterminer(prs:Personer, str:StudieterminerExt) {
		var stAlts:Array<String> = [];
		for (st in str) {
			stAlts.push(st.namn);	
		}
		
		for (p in prs) {
			var id = p.efternamn + ', ' + p.fornamn + ' (' + p.personnr + ')';
			for (st in p.studieterminer) {
				validInArray('Person/Studieterminer', id, st, stAlts);
			}
			
		}
		
		
	}
	
	static private function checkPersonerAdmingrupper(prs:Personer, adgr:Admingrupper) {
		var stAlts:Array<String> = [];
		for (a in adgr) {
			stAlts.push(a.gruppnamn);	
		}
		
		for (p in prs) {
			var id = p.efternamn + ', ' + p.fornamn + ' (' + p.personnr + ')';			
			if (p.roll == 'administratör') continue;
			if (p.roll == 'ledare') continue;
			if (p.roll == 'grupp') continue;
			validInArray('Person/Studieterminer', id, p.admgrupp, stAlts);
		}		
		
	}

	static private function checkPersonerKorer(prs:Personer, korer:Korer) {
		var stAlts:Array<String> = [];
		for (k in korer) {
			stAlts.push(k.namn);	
		}	

		for (p in prs) {
			var id = p.efternamn + ', ' + p.fornamn + ' (' + p.personnr + ')';			
			if (p.roll == 'administratör') continue;
			validInArray('Person/Studieterminer', id, p.kor, stAlts);
		}				
		
	}
	
	
	//-----------------------------------------------------------------------------------------------------
	
	static private function validStringLength(type:String, id:String,  checkString:String, length:Int) {
		if (checkString.length < length) addError(type, id, checkString  + ' is shorter than ' + length + ' chars');
	}
	
	static private function validEmail(type:String, id:String, checkEmail:String) {
		var emailExpression : EReg = ~/^[\w-\.]{2,}@[\w-\.]{2,}\.[a-z]{2,6}$/i;		
		if (!emailExpression.match(checkEmail)) addError(type, id, checkEmail + ' is not valid email-address');
	}
	
	static private function validDate(type:String, id:String, checkDateString:String) {
		try {
			var checkDate = Date.fromString(checkDateString);
		} catch (e:Dynamic) {
			addError(type, id, checkDateString + ' is not a valid date');
		}
	}
	
	static private function validCharacters(type:String, id:String, checkString:String, chars:Array<String>) {
		for (ch in chars) {
			if (checkString.indexOf(ch) > -1) addError(type, id, checkString + ': Not allowed character(s): ' + ch);
		}
	}
	
	static private function validPersonnummer(type:String, id:String, checkPnr:String) {
		if (checkPnr.length != 11) addError(type, id, checkPnr + ' length is not 11 chars');		
		if (checkPnr.charAt(6) != '-') addError(type, id, checkPnr + ' char nr 6 is not "-"');
		var yr = checkPnr.substr(0, 2);
		var year = (Std.parseInt(yr) > 20) ? '19' + yr : '20' + yr;
		var month = checkPnr.substr(2, 2);
		var day =  checkPnr.substr(4, 2);
		if (Std.string(Std.parseInt(year + month + day)) != year + month + day)    addError(type, id, year + month + day + ' birthdate seem to be wrong'); 
		
		var flast = checkPnr.substr(7);
		if (Std.string(Std.parseInt('1' + flast)) != '1' + flast) addError(type, id, flast + ' four last numbers seem to be wrong'); 
		//trace(Std.parseInt(year + month + day));
		var dateStr = year + '-' + month + '-' + day;
		//trace(dateStr);
		try { var date = Date.fromString(dateStr); } catch (e:Dynamic) { addError(type, id, dateStr + ' seems to be wrong');  };
	}
	
	static public function validFirstUppercase(type:String, id:String, checkString:String, exceptionlist:String='') {
		var ex = exceptionlist.split(',');		
		if (ex.length > 0) {
			for (e in ex) {
				if (e != '') if (StringTools.startsWith(checkString, e)) return;
			}
		}
		var first = checkString.substr(0, 1);		
		if (first != first.toUpperCase()) addError(type, id, checkString + ' - first char is not uppercase');
	}
	
	static public function validLan(type:String, id:String, checkLan:String) {
		if (Lambda.indexOf(aLan, checkLan) < 0) addError(type, id, checkLan + ' is not a valid county');
		//trace(Lambda.indexOf(aLan, checkLan));
	}
	
	static public function validInArray(type:String, id:String, item:String, items:Array<String>) {
		//trace( ' check if ' + item + ' is part of ' + items);
		if (Lambda.indexOf(items, item) < 0) addError(type, id, item + ' is not a valid alternative in ' + items.join('/') + '');
		
	}
	
	static public function validAltsInArray(type:String, id:String, alts:String, items:Array<String>) {
		
		//if (!Tools.arraysOverlap(alts, items)) addError(type, id, item + ' finns inte bland alternativen ' + items.join(','));
		
		//for
		//if (Lambda.indexOf(items, item) < 0) addError(type, id, item + ' finns inte bland alternativen ' + items.join(','));
		
	}	
	
	
	
}

typedef IntegrityError = {
	type:String,
	id:String,
	msg:String,
	//ex:String,
}

typedef IntegrityErrors = Array<IntegrityError>;
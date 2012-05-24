package ka.tools;
import cx.ReflectTools;
import cx.StrTools;
import ka.types.Person;
import ka.types.Personer;

/**
 * ...
 * @author Jonas Nyström
 */

class PersonTools 
{
	static public function getFromString(str:String, separator:String = '|'):Person {
		var a = str.split(separator);
		//jonasnys@gmail.com|cambiata|Nyström|Jonas|administratör|-
		var p = getPersonNull();
		p.epost = a[0];
		p.xpass = a[1];
		p.efternamn = a[2];
		p.fornamn = a[3];
		p.roll = a[4];	
		
		return p;
	}
	
	/*
	static public function getPersonArgs(
		personnr:String,
		fornamn:String,
		efternamn:String,
		epost:String,
		gatuadr:String,
		postnr:String,
		postadr:String,
		lan:String,
		roll:String,
		kor:String,
		admgrupp:String,
		studieterminer:String,
		studiestart:String,
		studieavslut:String,
		loggstudier:String,
		loggpersonligt:String,
		anteckningar:String,
		xpass:String):Person {
			var p:Person = getPersonNull();
			p.personnr = personnr;
			p.fornamn = fornamn;
			p.efternamn = efternamn;
			p.epost = epost;
			p.gatuadr = gatuadr;
			p.postnr = postnr;
			p.postadr = postadr;
			p.lan = lan;
			p.roll = roll;
			p.kor = kor;
			p.admgrupp = admgrupp;
			p.studieterminer = studieterminer;
			p.studiestart = studiestart;
			p.studieavslut = studieavslut;
			p.loggstudier = loggstudier;
			p.loggpersonligt = loggpersonligt;
			p.anteckningar = anteckningar;
			p.xpass = xpass;
			return p;
	}
	*/
	
	static public function getPersonNull():Person {	
		var p:Person = {
		sheetrow:0,
		personnr:null,
		fornamn:null,
		efternamn:null,
		epost:null,
		gatuadr:null,
		postnr:null,
		postadr:null,
		lan:null,
		roll:null,
		kor:null,
		admgrupp:null,
		studieterminer:null,
		studiestart:null,
		studieavslut:null,
		loggstudier:null,
		loggpersonligt:null,
		anteckningar:null,
		xpass:null };		
		return p;				
	}
	

	
	
	static public function getPersonFejk():Person {	
		var p:Person = {
		sheetrow:0,
		personnr:'221130-5676',
		fornamn:'Jönis',
		efternamn:'de Laval',
		epost:'jonis@delaval.se',
		gatuadr:'Sugstigen 32',
		postnr:'89654',
		postadr:'Örkelhåla',
		lan:'Skåne län',
		roll:'deltagare',
		kor:'Superkören',
		admgrupp:'Musiklinjen 3',
		studieterminer:['2012b'],
		studiestart:null,
		studieavslut:null,
		loggstudier:null,
		loggpersonligt:null,
		anteckningar:null,
		xpass:null };		
		return p;				
	}	
	
	static public function compare(personA:Person, personB:Person) {
		var fields = ReflectTools.getObjectFields(personA);
		
		var diffFields = new Array<String>();
		for (field in fields) {
			var valueA = Reflect.field(personA, field);
			var valueB = Reflect.field(personB, field);
			if (Std.string(valueA) != Std.string(valueB)) diffFields.push(field);
		}

		return diffFields;		
	}
	
	static public function getPersonFieldCol(field:String):Int {
		var c = 0;
		switch(field) {
			case 'personnr': c =  0;
			case 'fornamn': c =  1;
			case 'efternamn': c =  2;
			case 'epost': c =  3;
			case 'gatuadr': c =  4;
			case 'postnr': c =  5;
			case 'postadr': c =  6;
			case 'lan': c =  7;
			case 'roll': c =  8;
			case 'kor': c =  9;
			case 'admgrupp': c =  10;
			case 'studieterminer': c = 11;
			case 'studiestart': c =  12;
			case 'studieavslut': c =  13;
			case 'loggstudier': c =  14;
			case 'loggpersonligt': c =  15;
			case 'anteckningar': c =  16;
			case 'xpass': c =  17;			
			default: c = -1;
		}
		return c + 1;
	}
	
	static public function searchPersoner(personer:Personer, search:String) {
		trace(search);		
		//var sis = new Array<SearchItem>();
		var ret = new Personer();
		for (person in personer) {
			var value = person.efternamn + ', ' + person.fornamn + person.personnr + person.epost;
			value = value.toLowerCase();
			if (value.indexOf(search) > -1) ret.push(person);
			/*
			var score = StrTools.similarityCaseIgnore(person.efternamn, search);
			var si:SearchItem = {
				string:search,
				score:score,
				person:person,
			}
			sis.push(si);
			*/
			
		}
		
		/*
		sis.sort(function(a, b) { return Reflect.compare(a.score, b.score); } );
			
		
		for (si in sis) {
			if (si.score > 0.4) ret.unshift(si.person);
		}
		*/
			
		return ret;		
	}
	
	
	
	
}

typedef SearchItem = {
	string:String,
	score:Float,
	person:Person,
}
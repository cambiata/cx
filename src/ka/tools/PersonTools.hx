package ka.tools;
import cx.ExcelTools;
import cx.ReflectTools;
import cx.StrTools;
import cx.ValidationTools;
import ka.types.Avantifields;
import ka.types.Avantiperson;
import ka.types.Avantipersoner;
import ka.types.Person;
import ka.types.Personer;

/**
 * ...
 * @author Jonas Nyström
 */
using cx.StrTools;
class PersonTools 
{
	static public function getFromString(str:String, separator:String = '|'):Person {
		var a = str.split(separator);

		var p = getPersonNull();
		p.epost = a[0];
		p.xpass = a[1];
		p.personid = a[2];		
		p.efternamn = a[3];
		p.fornamn = a[4];
		p.roll = a[5];			
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
		personid:null,
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
		scorxtillg:null,
		xpass:null };	
		return p;				
	}
	

	
	
	static public function getPersonFejk():Person {	
		var p:Person = {
		sheetrow:0,
		personnr:'221130-5676',
		personid:'AAAAAA',
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
		scorxtillg:null,
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
		}
		return ret;		
	}
	
	
	static public function peronnrToId(personnr:String):String {
		
		var rotateNr = Std.parseInt(personnr.substr( -1));
		var rotateChar = StrTools.intToChar(rotateNr);
		//trace(rotateNr);
		//trace(rotateChar);
		
		var id = personnr;		
		id = personnr.split('-').join('');
		
		
		var s1 = id.substr(0, 4);
		var s2 = id.substr(4, 4);
		var s3 = id.substr(8, 4);
		
		s1 = s1.reverse();
		s2 = s2.reverse();
		s3 = s3.reverse();
		
		s1 = intsToChars(s1);
		s2 = intsToChars(s2);
		s3 = intsToChars(s3);
		//-------------------------------------------------------

		var result = StrTools.rotate(s3 + s2 + s1, rotateNr) + rotateChar;
		return result;
	}
	
	static public function personidToNr(id:String):String {
		
		var rotateChar = id.substr(-1); // StrTools.intToChar(rotateNr);
		var rotateNr = StrTools.charToInt(rotateChar);
		//trace(rotateChar);		
		//trace(rotateNr);
		
		id = StrTools.rotateBack(id.substr(0, id.length - 1), rotateNr);
		
		
		var s1 = id.substr(0, 4);
		var s2 = id.substr(4, 4);
		var s3 = id.substr(8, 4);
		
		s1 = charsToInts(s1);
		s2 = charsToInts(s2);
		s3 = charsToInts(s3);
		
		s1 = s1.reverse();
		s2 = s2.reverse();
		s3 = s3.reverse();
		
		//-------------------------------------------------------
		
		var result = s3 + s2 + '-' + s1;
		return result;
	}
	

	
	static private function  intsToChars(ints:String):String {
		var result = '';
		for (i in 0...ints.length) {
			var int:Int = Std.parseInt(ints.charAt(i));
			var char = StrTools.intToChar(int, i);
			//trace([int, char]);			
			result = result + char;
		}
		return result;
	}
	
	static private function charsToInts(chars:String):String {
		var result = '';
		for (i in 0...chars.length) {
			var char:String = chars.charAt(i); 
			var int = StrTools.charToInt(char, i);
			var intChar = Std.string(int);
			result = result + intChar;
		}
		
		return result;
	}
	

	
	

	
	
	
}





typedef SearchItem = {
	string:String,
	score:Float,
	person:Person,
}
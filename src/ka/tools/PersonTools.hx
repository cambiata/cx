package ka.tools;
import ka.types.Person;

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
}
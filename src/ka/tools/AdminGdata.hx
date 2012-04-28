package ka.tools;
import cx.Tools;
import ka.types.Admingrupp;
import ka.types.Admingrupper;
import ka.types.Kor;
import ka.types.Korer;
import ka.types.Person;
import ka.types.Personer;
import ka.types.Studietermin;
import ka.types.Studieterminer;
import ka.types.StudieterminerExt;
import ka.types.StudieterminExt;

/**
 * ...
 * @author Jonas Nyström
 */
using StringTools;
class AdminGdata 
{
	static var email = 'jonasnys';
	static var passwd = '%gloria!';
	static var sheetPersoner = '0Ar0dMoySp13UdFNOdXNjenRJd3pyLW9GWlFJTXdrX0E';
	static var sheetData = '0Ar0dMoySp13UdDZuelAyRmFSektpOTZNeWhFeHVkbGc';	
	static var pageDataStudieterminer = 0;
	static var pageDataAdmingrupper = 1;
	static var pageDataKorer = 2;	
	
	
	static private var studieterminer:Studieterminer;
	
	static public function getStudieterminer():Studieterminer {
		return studieterminer;
	}
	
	static public function getStudieterminerExt():StudieterminerExt {

		var g = new cx.GoogleTools.Spreadsheet(email, passwd, sheetData, pageDataStudieterminer);
		var cells = g.getCells();		
		var studieterminerExt = new StudieterminerExt();
		
		for (cell in cells) {
			var studieterminExt:StudieterminExt = {namn:null, start:null, slut:null};
			studieterminExt.namn = cell[0];
			studieterminExt.start = (cell[1] != null) ? Date.fromString(cell[1]) : null;
			studieterminExt.slut = (cell[1] != null) ? Date.fromString(cell[2]) : null;
			studieterminerExt.push(studieterminExt);
		}
		
		studieterminer = new Studieterminer();
		for (stExt in studieterminerExt) {
			var st:Studietermin = stExt.namn;
			studieterminer.push(st);
		}		
		
		return studieterminerExt;
	}
	
	static public function getAdmingrupper():Admingrupper {
		var g = new cx.GoogleTools.Spreadsheet(email, passwd, sheetData, pageDataAdmingrupper);
		var cells = g.getCells();				
		var admingrupper = new Admingrupper();
		for (cell in cells) {
			if (cell[0].trim() == '') continue;
			var gruppnamn = cell[0];
			var studieterminer:Studieterminer = cx.Tools.splitTrim(cell[1]);			
			var grupp:Admingrupp = { gruppnamn:gruppnamn, studieterminer:studieterminer };
			admingrupper.push(grupp);
		}
		return admingrupper;
	}

	static public function getKorer():Korer {
		var g = new cx.GoogleTools.Spreadsheet(email, passwd, sheetData, pageDataKorer);
		var cells = g.getCells();				
		var korer = new Korer();
		for (cell in cells) {
			if (cell[0].trim() == '') continue;
			var namn = cell[0];			
			var studieterminer:Studieterminer = Tools.splitTrim(cell[1]);			
			var kor:Kor = { namn:namn, studieterminer:studieterminer };
			korer.push(kor);
		}		
		return korer;
	}
	
	static var personerFields:Person;
	
	static public function getPersonerFields():Person {
		return personerFields;
	}
	
	static public function getPersoner():Personer {
		
		var g = new cx.GoogleTools.Spreadsheet(email, passwd, sheetPersoner);
		var cells = g.getCells();		
		//fieldsPersoner = cells.shift();		
		var dataPersoner = new Personer();		
		for (cell in cells) {			
			var p:Person = {
				personnr:cell[0],
				fornamn:cell[1],
				efternamn:cell[2],
				epost:cell[3],
				gatuadr:cell[4],
				postnr:cell[5],
				postadr:cell[6],
				lan:cell[7],
				roll:cell[8],
				kor:cell[9],
				admgrupp:cell[10],
				studieterminer:Tools.splitTrim(cell[11], ',') ,
				studiestart:cell[12],
				studieavslut:cell[13],
				loggstudier:cell[14],
				loggpersonligt:cell[15],
				anteckningar:cell[16],
				xpass:cell[17],
			}
			dataPersoner.push(p);			
		}
		
		personerFields = dataPersoner.shift();
		
		for (person in dataPersoner) {
			if ((person.xpass == null)||(person.xpass == '')) {
				person.xpass = person.personnr.substr( -4);				
			}			
		}
		
		return dataPersoner;
		
	}
}
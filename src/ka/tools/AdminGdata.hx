package ka.tools;
import cx.google.Goo;
import cx.StrTools;
import cx.Tools;
import ka.types.Admingrupp;
import ka.types.Admingrupper;
import ka.types.Kor;
import ka.types.Korer;
import ka.types.Person;
import ka.types.Personer;
import ka.types.Scorxtillganglighet;

import ka.types.Scorxtillgangligheter;
import ka.types.Studietermin;
import ka.types.Studieterminer;
import ka.types.StudieterminerExt;
import ka.types.StudieterminExt;
import ka.app.KalleConfig;

/**
 * ...
 * @author Jonas Nyström
 */
using StringTools;
using cx.ArrayTools;
class AdminGdata 
{
	/*
	static var email = 'jonasnys';
	static var passwd = '%gloria!';
	static var sheetPersoner = '0Ar0dMoySp13UdFNOdXNjenRJd3pyLW9GWlFJTXdrX0E';
	static var sheetData = '0Ar0dMoySp13UdDZuelAyRmFSektpOTZNeWhFeHVkbGc';	
	static var pageDataStudieterminer = 0;
	static var pageDataAdmingrupper = 1;
	static var pageDataKorer = 2;	
	*/
	
	static var email = KalleConfig.email;
	static var passwd = KalleConfig.passwd  ;
	static var sheetPersoner = KalleConfig.sheetPersoner  ;
	static var sheetData = KalleConfig.sheetData  ;
	static var pageDataStudieterminer = KalleConfig.pageDataStudieterminer  ;
	static var pageDataAdmingrupper = KalleConfig.pageDataAdmingrupper  ;
	static var pageDataKorer = KalleConfig.pageDataKorer  ;	
	static var pageDatagetScorxtillgangligheter = KalleConfig.pageScorxtillgangligheter;
	
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
			try {
				studieterminExt.start = (cell[1] != null) ? Date.fromString(cell[1]) : null;
			} catch (e:Dynamic) {
				studieterminExt.start = Date.fromString('2000-01-01');
			}
			
			try {
				studieterminExt.slut = (cell[1] != null) ? Date.fromString(cell[2]) : null;
			} catch (e:Dynamic) {
				studieterminExt.slut = Date.fromString('2000-01-01');
			}

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
			var studieterminer:Studieterminer = cx.StrTools.splitTrim(cell[1]);			
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
			var studieterminer:Studieterminer = StrTools.splitTrim(cell[1]);			
			var kor:Kor = { namn:namn, studieterminer:studieterminer };
			korer.push(kor);
		}		
		return korer;
	}
	
	static public function getScorxtillgangligheter():Scorxtillgangligheter {
		var g = new cx.GoogleTools.Spreadsheet(email, passwd, sheetData, pageDatagetScorxtillgangligheter);
		var cells = g.getCells();				
		var scorxtillgangligheter = new Scorxtillgangligheter();		
		
		for (cell in cells) {
			if (cell[0].trim() == '') continue;		
			var kat = cell[0];			
			var mappar = cell[1];
			//trace(kat);
			//trace(mappar);			
			var st:Scorxtillganglighet = { kategori:kat, mappar:mappar.split(',')};
			scorxtillgangligheter.push(st);
		}
		//trace(scorxtillgangligheter);
		return scorxtillgangligheter;
	}
	
	
	static var personerFields:Person;
	
	static public function getPersonerFields():Person {
		return personerFields;
	}
	
	static public function getPersoner():Personer {
		
		var g = new cx.GoogleTools.Spreadsheet(email, passwd, sheetPersoner);
		var cells = g.getCells();		
		//fieldsPersoner = cells.shift();		
		var rowNr = 1;
		var dataPersoner = new Personer();		
		for (cell in cells) {			
			var p:Person = {
				sheetrow:rowNr,
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
				studieterminer:StrTools.splitTrim(cell[11], ',') ,
				studiestart:cell[12],
				studieavslut:cell[13],
				loggstudier:cell[14],
				loggpersonligt:cell[15],
				anteckningar:cell[16],
				xpass:cell[17],
			}
			dataPersoner.push(p);			
			rowNr++;
		}
		
		personerFields = dataPersoner.shift();
		
		for (person in dataPersoner) {
			if ((person.xpass == null)||(person.xpass == '')) {
				person.xpass = person.personnr.substr( -4);				
			}			
		}
		
		return dataPersoner;
		
	}
	
	static public function setPersonData(row:Int, col:Int, value:String) {
		var authToken = Goo.getAuthToken(email, passwd);
		trace(authToken);		
		var xmlWorksheet = Goo.getXmlWorksheet(authToken, sheetPersoner);
		var sheetsInfo = Goo.getSheetsInfo(xmlWorksheet, sheetPersoner);
		var firstSheet = sheetsInfo.first();
		trace(firstSheet);
		
		var cellEntry = Goo.getCellChangeEntry(sheetPersoner, firstSheet.id, row, col, value);
		var cellUrl = Goo.getCellFeedUrl(sheetPersoner, firstSheet.id, row, col);
		
		trace(cellUrl);
		trace(cellEntry);
		
		var result = Goo.updateCell(authToken, cellUrl, cellEntry);
		trace(result);
	}
}
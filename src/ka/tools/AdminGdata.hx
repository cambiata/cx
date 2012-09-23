package ka.tools;
import cx.google.Goo;
import cx.StrTools;
import cx.Tools;
import cx.ValidationTools;
import ka.types.Admingrupp;
import ka.types.Admingrupper;
import ka.types.Kor;
import ka.types.Korer;
import ka.types.Person;
import ka.types.Personer;
import ka.types.Roll;
import ka.types.Scorxtillganglighet;
import ka.types.Roller;

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
	//static var sheetPersoner = KalleConfig.sheetPersoner  ;
	static var sheetPersoner2 = KalleConfig.sheetPersoner2;
	static var sheetData = KalleConfig.sheetData  ;
	static var pageDataStudieterminer = KalleConfig.pageDataStudieterminer  ;
	static var pageDataAdmingrupper = KalleConfig.pageDataAdmingrupper  ;
	static var pageDataKorer = KalleConfig.pageDataKorer  ;	
	static var pageDataRoller = KalleConfig.pageDataRoller  ;	
	static var pageDatagetScorxtillgangligheter = KalleConfig.pageScorxtillgangligheter;
	
	
	
	static private var studieterminer:Studieterminer;
	
	
	static public var invalidPersonerEpost:Personer = [];
	static public var invalidPersonerPersonnr:Personer = [];
	
	
	
	static public function getStudieterminer():Studieterminer {
		return studieterminer;
	}
	
	static public function getStudieterminerExt():StudieterminerExt {

		var g = new cx.GoogleTools.Spreadsheet(email, passwd, sheetData, pageDataStudieterminer);
		var cells = g.getCells();		
		var studieterminerExt = new StudieterminerExt();
		
		for (cell in cells) {
			if (cell == null) continue;
			
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
			if (cell == null) continue;
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
			if (cell == null) continue;
			if (cell[0].trim() == '') continue;
			var namn = cell[0];			
			var studieterminer:Studieterminer = StrTools.splitTrim(cell[1]);			
			var kor:Kor = { namn:namn, studieterminer:studieterminer };
			korer.push(kor);
		}		
		return korer;
	}
	
	static public function getRoller():Roller {
		var g = new cx.GoogleTools.Spreadsheet(email, passwd, sheetData, pageDataRoller);
		var cells = g.getCells();				
		var roller = new Roller();
		for (cell in cells) {
			if (cell == null) continue;
			if (cell[0].trim() == '') continue;
			var namn = cell[0];			
			var info = cell[1];			
			//var kor:Kor = { namn:namn, studieterminer:studieterminer };
			var roll:Roll = { namn: namn, info:info };
			roller.push(roll);
		}	
		
		return roller;
	}	
	
	static public function getScorxtillgangligheter():Scorxtillgangligheter {
		var g = new cx.GoogleTools.Spreadsheet(email, passwd, sheetData, pageDatagetScorxtillgangligheter);
		var cells = g.getCells();				
		var scorxtillgangligheter = new Scorxtillgangligheter();		
		
		for (cell in cells) {
			if (cell == null) continue;
			if (cell[0].trim() == '') continue;		
			var kat = cell[0];			
			var mappar = cell[1];
			//trace(kat);
			//trace(mappar);			
			var st:Scorxtillganglighet = { kategori:kat, mappar:mappar.split(','), ids:[]};
			scorxtillgangligheter.push(st);
		}
		//trace(scorxtillgangligheter);
		return scorxtillgangligheter;
	}
	
	
	static var personerFields:Person;
	
	static public function getPersonerFields():Person {
		return personerFields;
	}
	/*
	static public function getPersonerX():Personer {
		
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
	*/
	
	static public function setPersonData(row:Int, col:Int, value:String) {
		
		/*
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
		*/
	}
	
	static public function getPersoner(onlyValid:Bool=true):Personer {		
		
		var g = new cx.GoogleTools.Spreadsheet(email, passwd, sheetPersoner2);
		
		var cells = g.getCells();				
		//var rowNr = 1;
		var dataPersoner = new Personer();		
		for (cell in cells) {			
			if (cell == null) continue;
			
			var p:Person = PersonTools.getPersonNull();
			p.xpass = cell[3];
			p.roll = cell[4];
			p.kor = cell[5];
			p.studieterminer = StrTools.splitTrim(cell[6], ',');			
			p.efternamn = cell[7];
			p.fornamn = cell[8];
			p.gatuadr = cell[11];
			p.postnr = cell[12];
			p.postadr = cell[13];
			p.personnr = cell[14];
			p.epost = cell[17];
			
			if ((p.xpass == null)||(p.xpass == '')) {
				if (p.personnr != null) p.xpass = p.personnr.substr(-4);				
			}		
			
			//------------------------------------------------------------------------------
			// validation
			
			if (p.fornamn == null && p.efternamn == null) continue;
			
			if (onlyValid) {
				if (! ValidationTools.isValidEmail(p.epost)) {
					invalidPersonerEpost.push(p);
					continue;
				}
	
				if (! ValidationTools.isValidPersonnrLong(p.personnr)) {
					invalidPersonerPersonnr.push(p);
					continue;
				}
			}
			
			//-------------------------------------------------------------------------------
			
			dataPersoner.push(p);			
			//rowNr++;
		}
		
		personerFields = dataPersoner.shift();
		
		return dataPersoner;
		
	}
	
	
}
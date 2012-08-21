package smd.server.sx.user;

import cx.EncodeTools;
import cx.MathTools;
import cx.SqliteTools;
import cx.Tools;
import ka.app.KalleConfig;
import ka.tools.PersonerExport;
import ka.tools.ScorxtillganglighetTools;
import ka.types.Person;
import ka.types.Personer;
import ka.types.Scorxtillgangligheter;
import ka.types.Studieterminer;
import ka.types.StudieterminerExt;
import neko.Lib;
import ka.tools.AdminGdata;
import neko.Sys;
import neko.Web;
import smd.server.ka.config.Config;


/**
 * ...
 * @author Jonas Nyström
 */
using ka.tools.PersonFilter;
using cx.StrTools;
class Access 
{

	static var email = KalleConfig.email;
	static var passwd = KalleConfig.passwd  ;
	static var sheetPersoner = KalleConfig.sheetPersoner  ;
	static var sheetData = KalleConfig.sheetData  ;
	static var pageDataStudieterminer = KalleConfig.pageDataStudieterminer;
	static var pageDataAdmingrupper = KalleConfig.pageDataAdmingrupper;
	static var pageDataKorer = KalleConfig.pageDataKorer;	
	
	static public var fieldsPerson:Person;
	static public var dataPersoner:Personer;	
	static public var dataScorxtillgangligheter:Scorxtillgangligheter;	
	static public var dataStudieterminerExt:StudieterminerExt;
	static public var filterStudieterminer:Studieterminer;	
	static public var resultPersoner:Personer;	
	
	static public function saveAuthInfoToFile(authFilename:String) {
		toAuthfile(authFilename, getPersoner(), dataScorxtillgangligheter);
	}
	
	static public function saveAuthInfoToSqlite(sqliteFileName:String) {
		toSqlite(sqliteFileName, getPersoner(), dataScorxtillgangligheter);
	}	
	
	static public function getPersoner(): Personer {
		dataPersoner = AdminGdata.getPersoner();
		fieldsPerson = AdminGdata.getPersonerFields();	
		dataScorxtillgangligheter = AdminGdata.getScorxtillgangligheter();
		dataStudieterminerExt = AdminGdata.getStudieterminerExt();		
		var filterdate:Date = Date.now();
		filterStudieterminer = setStudieterminerFiletToDate(filterdate);
		resultPersoner = applyFilters(dataPersoner);
		return resultPersoner;
	}
	
	static public function setStudieterminerFiletToDate(date:Date) {		
		var filterStudieterminer = new Studieterminer();
		for (se in dataStudieterminerExt) {
			if (se.start != null) {				
				if (MathTools.inRange(se.start.getTime(), date.getTime(), se.slut.getTime())) {
					filterStudieterminer.push(se.namn);	
				}			
			}
		}
		return filterStudieterminer;
	}
	
	static public function applyFilters(dataPersoner:Personer) {
		var tempPersoner:Personer = dataPersoner.copy();
		if (filterStudieterminer != null) if (filterStudieterminer.length > 0) tempPersoner = tempPersoner.filterStudieterminer(filterStudieterminer);
		//if (filterKorer != null) if (filterKorer.length > 0) tempPersoner = tempPersoner.filterKorer(filterKorer);
		//if (filterAdmingrupper != null) if (filterAdmingrupper.length > 0) tempPersoner = tempPersoner.filterAdmingrupper(filterAdmingrupper);
		return tempPersoner;
	}	
	
	
	static public function toAuthfile(filename:String, personer:Personer, scorxTillg:Scorxtillgangligheter) {		
		//trace(filename);
		var f = neko.io.File.write(filename, false);
		//f.writeString('----------------------------------------------------------------------------\n');
		for (person in personer) {
			var tillg = ScorxtillganglighetTools.getTillganglighet(scorxTillg, person.roll, person.kor, person.personnr );
			var tillgStr = tillg.join(',');			
			var a = [person.epost, person.xpass, person.efternamn, person.fornamn, person.roll, cx.StrTools.replaceNull(person.kor), tillgStr];			
			var str = a.join('|') + '\n';
			f.writeString(str);			
		}
		f.close();			
	}	
	
	static public function toSqlite(filename:String, personer:Personer, scorxTillg:Scorxtillgangligheter, logCallback:String->Void=null) {
		var sql = 'DELETE FROM "personer"';
		try {			
			var result = SqliteTools.execute(filename, sql);
			//trace(result);
		} catch (e:Dynamic) {
			var msg = 'Can not run sql: ' + sql + ' on the sqlite file: ' + filename;
			(logCallback != null) ? logCallback(msg) : trace(msg);
		}
		for (person in personer) {
			var tillg = ScorxtillganglighetTools.getTillganglighet(scorxTillg, person.roll, person.kor, person.personnr );
			var scorxtillg = tillg.join(',');
			
			var insertPersonObject:Dynamic = {
				personnr: person.personnr,
				epost: person.epost,
				xpass: person.xpass,
				efternamn: person.efternamn,
				fornamn: person.fornamn,
				roll: person.roll,
				kor: person.kor,
				scorxtillg: scorxtillg,				
			}
			
			var sql = SqliteTools.getInsertStatement(insertPersonObject, "personer");			
			try {
				var result = SqliteTools.insert(filename, sql);
			} catch (e:Dynamic) {
				var msg = 'Can not run sql: ' + sql + ' on the sqlite file: ' + filename;
				(logCallback != null) ? logCallback(msg) : trace(msg);
			}
		}		
	}
	
}
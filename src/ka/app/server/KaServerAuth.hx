package ka.app.server;
import cx.EncodeTools;
import cx.Tools;
import ka.app.KalleConfig;
import ka.tools.PersonerExport;
import ka.types.Person;
import ka.types.Personer;
import ka.types.Scorxtillgangligheter;
import ka.types.Studieterminer;
import ka.types.StudieterminerExt;
import neko.Lib;
import ka.tools.AdminGdata;
import neko.Sys;
import neko.Web;

/**
 * ...
 * @author Jonas Nyström
 */

using ka.tools.PersonFilter;
class KaServerAuth 
{	
	static function main() {
		new KaServerAuth();
		
	}
	
	static var email = KalleConfig.email;
	static var passwd = KalleConfig.passwd  ;
	static var sheetPersoner = KalleConfig.sheetPersoner  ;
	static var sheetData = KalleConfig.sheetData  ;
	static var pageDataStudieterminer = KalleConfig.pageDataStudieterminer  ;
	static var pageDataAdmingrupper = KalleConfig.pageDataAdmingrupper  ;
	static var pageDataKorer = KalleConfig.pageDataKorer  ;	
	
	static public var fieldsPerson:Person;
	static public var dataPersoner:Personer;	
	static public var dataScorxtillgangligheter:Scorxtillgangligheter;	
	static public var dataStudieterminerExt:StudieterminerExt;

	static public var filterStudieterminer:Studieterminer;	
	static public var resultPersoner:Personer;
	
	public function new() 
	{
		
		Lib.println('loading data...');
		//trace(Sys.args());
		var filterdate:Date = Date.now();
		var tIdx = Lambda.indexOf(Sys.args(), '-d');
		if (tIdx >= 0) {
			var dateString = Sys.args()[tIdx + 1];
			filterdate = Date.fromString(dateString);			
			//trace(filterdate);
		}
		
		//trace('get persons...');
		dataPersoner = AdminGdata.getPersoner();
		fieldsPerson = AdminGdata.getPersonerFields();	
		dataScorxtillgangligheter = AdminGdata.getScorxtillgangligheter();
		//dataStudieterminerExt = AdminGdata.getStudieterminerExt();
		dataStudieterminerExt = AdminGdata.getStudieterminerExt();		
		//trace(dataStudieterminerExt);
		filterStudieterminer = setStudieterminerFiletToDate(filterdate);
		
		//trace(filterStudieterminer);		
		//trace(dataPersoner.length);
		
		resultPersoner = applyFilters(dataPersoner);
		
		//trace(resultPersoner.length);
		for (p in resultPersoner) {
			//Lib.println(EncodeTools.cliDecode(p.efternamn + ' ' + p.fornamn));			
		}
		PersonerExport.toAuthfile(Web.getCwd() + 'auth/autentisering.dat', resultPersoner, dataScorxtillgangligheter);
		Lib.println('authfile updated!');
	}
	
	static public function setStudieterminerFiletToDate(date:Date) {		
		var filterStudieterminer = new Studieterminer();
		for (se in dataStudieterminerExt) {
			if (se.start != null) {				
				if (Tools.inRange(se.start.getTime(), date.getTime(), se.slut.getTime())) {
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
	
	
}
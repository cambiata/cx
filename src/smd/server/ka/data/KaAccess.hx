package smd.server.ka.data;


import cx.EncodeTools;
import cx.MathTools;
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
class KaAccess 
{

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
	
	
	
	
	static public function update(authFilename:String, logCallback:String->Void=null) 
	{
		if (logCallback != null) logCallback('Start updating authfile... :' + authFilename);
		
		try {

			dataPersoner = AdminGdata.getPersoner();
			fieldsPerson = AdminGdata.getPersonerFields();	
			dataScorxtillgangligheter = AdminGdata.getScorxtillgangligheter();
			dataStudieterminerExt = AdminGdata.getStudieterminerExt();		
			
			var filterdate:Date = Date.now();
			filterStudieterminer = setStudieterminerFiletToDate(filterdate);
			
			resultPersoner = applyFilters(dataPersoner);
			
			/*
			for (p in resultPersoner) {
				//Lib.println(EncodeTools.cliDecode(p.efternamn + ' ' + p.fornamn));			
			}
			*/			
			//var authFilename = configFile.authDir + configFile.authFilename;
			
			try {
				ScorxtillganglighetTools.toAuthfile(authFilename, resultPersoner, dataScorxtillgangligheter);
			} catch (e:Dynamic) {
				if (logCallback != null) logCallback('Can not write to authfile ' + authFilename);
				return;
			}
	
			if (logCallback != null) logCallback('Finished updating authfile...');
			
		} catch (e:Dynamic) {
			
			if (logCallback != null) logCallback('ERROR updating authfile...');			
		}
		
		
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
	
}
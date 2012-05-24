import cx.FileTools;
import cx.google.Goo;
import cx.MathTools;
import cx.ReflectTools;
import cx.StrTools;
import haxe.Serializer;
import haxe.Unserializer;
import ka.app.KalleConfig;
import ka.tools.AdminGdata;
import ka.tools.Integrity;
import ka.tools.PersonTools;
import ka.types.Admingrupper;
import ka.types.Korer;
import ka.types.Person;
import ka.types.Personer;
import ka.types.Scorxtillgangligheter;
import ka.types.Studieterminer;
import ka.types.StudieterminerExt;
import neko.FileSystem;
import neko.io.File;
import neko.Lib;
import neko.Utf8;

/**
 * ...
 * @author Jonas Nyström
 */

class KalleWinData 
{

	static var email = KalleConfig.email;
	static var passwd = KalleConfig.passwd  ;
	static var sheetPersoner = KalleConfig.sheetPersoner  ;
	static var sheetData = KalleConfig.sheetData  ;
	static var pageDataStudieterminer = KalleConfig.pageDataStudieterminer  ;
	static var pageDataAdmingrupper = KalleConfig.pageDataAdmingrupper  ;
	static var pageDataKorer = KalleConfig.pageDataKorer  ;	
	
	 public var fieldsPerson:Person;
	 public var fieldsPersonHash:Hash<Int>;
	 public var dataPersoner:Personer;
	 public var dataStudieterminer:Studieterminer;
	 public var dataStudieterminerExt:StudieterminerExt;
	 public var dataAdmingrupper:Admingrupper;
	 public var dataScorxtillgangligheter:Scorxtillgangligheter;
	 public var dataKorer:Korer;
	
	 public var resultPersoner:Personer;

	 public var filterKorer:Korer;
	 public var filterAdmingrupper:Admingrupper;
	 public var filterStudieterminer:Studieterminer;
	
	
	 private var filenameDataPersoner:String ;
	 private var filenameFieldsPersoner:String ;
	 private var filenameHtmlPersoner:String ;
	 private var filenameEmailsPersoner:String ;	
	 private var filenameStudieterminerExt:String ;
	 private var filenameKorer:String ;
	 private var filenameAdmingrupper:String ;
	 private var filenameScorxtillgangligheter:String ;
	
	 static public var useCache:Bool = false;	
	

	
	public function new() {
		
	}
	
	
	public function initData() {
		
	   filenameDataPersoner = 'temp/personer.data';
	   filenameFieldsPersoner = 'temp/personer.fields';
	   filenameHtmlPersoner = 'temp/personer.html';
	   filenameEmailsPersoner = 'temp/emails.txt';	
	   filenameStudieterminerExt = 'temp/studieterminer-ext.data';
	   filenameKorer = 'temp/korer.data';
	   filenameAdmingrupper = 'temp/admingrupper.data';
	   filenameScorxtillgangligheter = 'temp/scorxtillgangligheter.data';		
		
		if (useCache) Lib.println(' *** USING CACHE *** ');
		
		filterKorer = new Korer();
		if (!FileSystem.exists('temp')) {
			FileSystem.createDirectory('temp');
		}
		
		if (FileSystem.exists(filenameDataPersoner)) {
			dataPersoner = Unserializer.run(File.getContent(filenameDataPersoner));
			fieldsPerson = Unserializer.run(File.getContent(filenameFieldsPersoner));
		} else {
			fetchPersoner();
		}
		
		if (FileSystem.exists(filenameStudieterminerExt)) {
			dataStudieterminerExt = Unserializer.run(File.getContent(filenameStudieterminerExt));
		} else {
			fetchStuditerminer();
		}
		dataStudieterminer = new Studieterminer();
		for (dse in dataStudieterminerExt) {
			dataStudieterminer.push(dse.namn);
		}

		if (FileSystem.exists(filenameAdmingrupper)) {
			dataAdmingrupper = Unserializer.run(File.getContent(filenameAdmingrupper));
		} else {
			fetchAdmingrupper();
		}

		if (FileSystem.exists(filenameKorer)) {
			dataKorer = Unserializer.run(File.getContent((filenameKorer)));
		} else {
			fetchKorer();
		}
		
		if (FileSystem.exists(filenameScorxtillgangligheter)) {
			dataScorxtillgangligheter = Unserializer.run(File.getContent((filenameScorxtillgangligheter)));
		} else {
			fetchScorxtillgangligheter();
		}		
		
		filterStudieterminer = dataStudieterminer.copy();
		filterStudieterminer = setStudieterminerFiletToDate(Date.now());
		filterAdmingrupper = new Admingrupper();
		filterKorer = new Korer();
		
		checkIntegrity();
		
	}		
	
	public function fetchPersoner() {
		//Lib.println(CliBase.decode('Hämtar personer...'));	
		log('Hämta personer...');
		dataPersoner = AdminGdata.getPersoner();
		fieldsPerson = AdminGdata.getPersonerFields();
		
		if (useCache) {
			FileTools.putContent(filenameDataPersoner, Serializer.run(dataPersoner));
			FileTools.putContent(filenameFieldsPersoner, Serializer.run(fieldsPerson));
		}
		
		
		//trace(dataPersoner);
	}	
	
	public function fetchStuditerminer() {
		log('Hämta studieterminer...');
		dataStudieterminerExt = AdminGdata.getStudieterminerExt();
		dataStudieterminer = AdminGdata.getStudieterminer();
		
		if (useCache) FileTools.putContent(filenameStudieterminerExt, Serializer.run(dataStudieterminerExt));	
	}
	
	public function fetchAdmingrupper() {
		log('Hämta administrativa grupper...');
		dataAdmingrupper = AdminGdata.getAdmingrupper();
		
		if (useCache) FileTools.putContent(filenameAdmingrupper, Serializer.run(dataAdmingrupper));		
	}	
	
	public function fetchKorer() {
		log('Hämta körer...');
		dataKorer = AdminGdata.getKorer();
		
		if (useCache) FileTools.putContent(filenameKorer, Serializer.run(dataKorer));		
	}	
	
	public function fetchScorxtillgangligheter() {
		log('Hämta scorxtillgängligheter...');
		dataScorxtillgangligheter = AdminGdata.getScorxtillgangligheter();		
		if (useCache) FileTools.putContent(filenameScorxtillgangligheter, Serializer.run(dataScorxtillgangligheter));		
		
	}
	
	public function setStudieterminerFiletToDate(date:Date) {
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
	
	
	//--------------------------------------------------------------------------------------------------------------------------------------
	
	
	public function displayPersoner(personer:Personer) {
		
		
	}
	
	private function log(message:String) {
		
		Lib.println(Utf8.encode(message));
	}	
	
	
	//-----------------------------------------------------------------------------------------------------
	
	 public function checkIntegrity() {		
		var errors = Integrity.check(dataPersoner, dataStudieterminerExt, dataAdmingrupper, dataKorer, fieldsPerson);
		//trace(errors);	
		displayErrors(errors);
	}	
	
	public function displayErrors(errors:IntegrityErrors) {
		if (errors.length > 0) {
			log('INTEGRITY ALERT! ' + errors.length + ' data integrity error(s):');
			for (error in errors) {
				var estr = ' - ' + StrTools.fill(error.type, 32, '.', '(null') + StrTools.fill(error.id, 40, '.') + error.msg;				
				log(estr);
			}			
		} else {
			log('Dataintegritet: OK! :-)');
		}
	}

	//-----------------------------------------------------------------------------------------------------
	
	public function updatePersonField(editPerson:Person, field:String) {
		var row = editPerson.sheetrow;
		var col = PersonTools.getPersonFieldCol(field);
		
		var value = Std.string(Reflect.field(editPerson, field));
		trace([row, col]);		
		
		AdminGdata.setPersonData(row, col, value);
	}
	
	
}
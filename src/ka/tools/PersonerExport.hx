package ka.tools;
import cx.EncodeTools;
import cx.ExcelTools;
import cx.FileTools;
import cx.StrTools;
import cx.Tools;
import ka.types.Person;
import ka.types.Personer;
import ka.types.Scorxtillgangligheter;

/**
 * ...
 * @author Jonas Nyström
 */

class PersonerExport 
{
	static public function toExcel(filename:String, personer:Personer) {		
		ExcelTools.start(filename);
		var row = 0;
		for (person in personer) {
			ExcelTools.writeString(row, 0, person.personnr);
			ExcelTools.writeString(row, 1, person.fornamn);
			ExcelTools.writeString(row, 2, person.efternamn);
			ExcelTools.writeString(row, 4, (person.kor != null) ? person.kor : '-');
			row++;
		}
		ExcelTools.finish();		
	}
	
	/*
	static public function toAuthfile(filename:String, personer:Personer, scorxTillg:Scorxtillgangligheter) {		
		var f = neko.io.File.write(filename, false);
		//f.writeString('----------------------------------------------------------------------------\n');
		for (person in personer) {
			var tillg = ScorxtillganglighetTools.getTillganglighet(scorxTillg, person.roll, person.kor, person.personnr );
			var tillgStr = tillg.join(',');
			
			var a = [person.epost, person.xpass, person.efternamn, person.fornamn, person.roll, StrTools.replaceNull(person.kor), tillgStr];
			
			var str = a.join('|') + '\n';
			f.writeString(str);			
		}
		f.close();			
	}
	*/
	
	static public function toEmailList(filename:String, personer:Personer) {
		var emails = PersonerTools.getPersonerEmails(personer);
		var str = emails.join(';');
		FileTools.putContentExecute(filename, str);				
	}
	
	/*
	static public function toEmailList(filename:String, personer:Personer) {		
	}
	*/
	
	static public function toHtml(filename:String, personer:Personer, ?fieldnames:Person) {		
		var html = cx.HtmlTools.getMeta() + PersonerTools.getPersonerHtml(personer, fieldnames);
		FileTools.putContentExecute(filename, html);			
	}
	
	static public function toStringlist(personer:Personer, ?fieldnames:Person) {
		var str = ' ';
		
		for (person in personer) {
			str +=		Tools.fillString(EncodeTools.cliDecode(person.efternamn)	, 16);
			str += 		Tools.fillString(EncodeTools.cliDecode(person.fornamn)		, 16);
			str += 		Tools.fillString(EncodeTools.cliDecode(person.personnr)	, 16);
			str += 		Tools.fillString(EncodeTools.cliDecode(person.lan)			, 20);
			str += 		Tools.fillString(EncodeTools.cliDecode(person.kor)			, 20);
			str += 		Tools.fillString(EncodeTools.cliDecode(person.roll)		, 16);
			str += 		Tools.fillString(EncodeTools.cliDecode(person.admgrupp)	, 16);
			str += 		Tools.fillString(EncodeTools.cliDecode(person.studieterminer.join(','))	, 24);
			//str += 		Tools.fillString(EncodeTools.cliDecode(person.roll)		, 16);
			str += '\n';
		}		
		return str;
	}
	
	
	
}
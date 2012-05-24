package cx.google;
import cx.FileTools;
import neko.io.Process;

/**
 * ...
 * @author Jonas Nyström
 */
using StringTools;
using cx.XmlTools;
using cx.StrTools;
class Goo 
{
	static public function getAuthToken(user:String, pass:String, service='wise') {		
		var proc = new Process ("curl", [
			'https://www.google.com/accounts/ClientLogin',
			'-d',
			'Email=' + user + '@gmail.com',
			'-d',
			'Passwd=' + pass,
			'-d',
			'accountType=HOSTED_OR_GOOGLE',
			'-d',
			'source=cURL-Example',
			'-d',
			'service=' + service,
			'-k'
		]);		
		
		var lines = new Array<String>();
		try  {
			while (true) {
				var line = proc.stdout.readLine ();
				lines.push(line);
			}
		} catch (e:Dynamic) { };
		proc.close();			
		
		var authToken = StringTools.replace(lines.pop(), 'Auth=', '');		
		return authToken;
	}
	
	static public function getXmlWorksheet(authToken:String, key:String) {
		var sheetUrl = 'https://spreadsheets.google.com/feeds/worksheets/key/private/full'.replace('key', key);		
		var proc = new Process ("curl", [
			'--header',
			'Authorization: GoogleLogin auth=' + authToken,
			sheetUrl,
			'-k'
		]);				
		var lines = new Array<String>();
		try  {
			while (true) {
				var line = proc.stdout.readLine ();
				lines.push(line);
			}
		} catch (e:Dynamic) { };
		proc.close();			
		return lines.shift();
	}
	
	static public function getXmlRows(authToken:String, listFeedUrl:String) {
		var proc = new Process ("curl", [
			'--header', 
			"Authorization: GoogleLogin auth=" + authToken, 
			listFeedUrl,
			'-k'
		]);	
		var lines = new Array<String>();
		try  {
			while (true) {
				var line = proc.stdout.readLine ();
				lines.push(line);
			}
		} catch (e:Dynamic) { };
		proc.close();			
		trace(lines);
		return lines.shift();		
	}	
	
	static public function getXmlCells(authToken:String, cellListUrl:String) {
		var proc = new Process ("curl", [
			'--header', 
			"Authorization: GoogleLogin auth=" + authToken, 
			cellListUrl,
			'-k'
		]);	
		var lines = new Array<String>();
		try  {
			while (true) {
				var line = proc.stdout.readLine ();
				lines.push(line);
			}
		} catch (e:Dynamic) { };
		proc.close();			
		trace(lines);
		return lines.shift();		
	}	
	
	
	static public function getSheetsInfo(xmlWorksheet:String, key:String) {
		//var worksheetXml = getWorksheet(authToken, key);
		//var worksheetXml = "<?xml version='1.0' encoding='UTF-8'?><feed xmlns='http://www.w3.org/2005/Atom' xmlns:openSearch='http://a9.com/-/spec/opensearchrss/1.0/' xmlns:gs='http://schemas.google.com/spreadsheets/2006'><id>https://spreadsheets.google.com/feeds/worksheets/0Ar0dMoySp13UdEtNYTZpcFNzVkYwWmMtUXRiVUJXVVE/private/full</id><updated>2012-05-24T07:52:50.024Z</updated><category scheme='http://schemas.google.com/spreadsheets/2006' term='http://schemas.google.com/spreadsheets/2006#worksheet'/><title type='text'>test</title><link rel='alternate' type='text/html' href='https://spreadsheets.google.com/ccc?key=0Ar0dMoySp13UdEtNYTZpcFNzVkYwWmMtUXRiVUJXVVE'/><link rel='http://schemas.google.com/g/2005#feed' type='application/atom+xml' href='https://spreadsheets.google.com/feeds/worksheets/0Ar0dMoySp13UdEtNYTZpcFNzVkYwWmMtUXRiVUJXVVE/private/full'/><link rel='http://schemas.google.com/g/2005#post' type='application/atom+xml' href='https://spreadsheets.google.com/feeds/worksheets/0Ar0dMoySp13UdEtNYTZpcFNzVkYwWmMtUXRiVUJXVVE/private/full'/><link rel='self' type='application/atom+xml' href='https://spreadsheets.google.com/feeds/worksheets/0Ar0dMoySp13UdEtNYTZpcFNzVkYwWmMtUXRiVUJXVVE/private/full'/><author><name>jonasnys</name><email>jonasnys@gmail.com</email></author><openSearch:totalResults>2</openSearch:totalResults><openSearch:startIndex>1</openSearch:startIndex><entry><id>https://spreadsheets.google.com/feeds/worksheets/0Ar0dMoySp13UdEtNYTZpcFNzVkYwWmMtUXRiVUJXVVE/private/full/od6</id><updated>2012-05-24T07:51:00.202Z</updated><category scheme='http://schemas.google.com/spreadsheets/2006' term='http://schemas.google.com/spreadsheets/2006#worksheet'/><title type='text'>sida1</title><content type='text'>sida1</content><link rel='http://schemas.google.com/spreadsheets/2006#listfeed' type='application/atom+xml' href='https://spreadsheets.google.com/feeds/list/0Ar0dMoySp13UdEtNYTZpcFNzVkYwWmMtUXRiVUJXVVE/od6/private/full'/><link rel='http://schemas.google.com/spreadsheets/2006#cellsfeed' type='application/atom+xml' href='https://spreadsheets.google.com/feeds/cells/0Ar0dMoySp13UdEtNYTZpcFNzVkYwWmMtUXRiVUJXVVE/od6/private/full'/><link rel='http://schemas.google.com/visualization/2008#visualizationApi' type='application/atom+xml' href='https://spreadsheets.google.com/tq?key=0Ar0dMoySp13UdEtNYTZpcFNzVkYwWmMtUXRiVUJXVVE&amp;sheet=od6'/><link rel='self' type='application/atom+xml' href='https://spreadsheets.google.com/feeds/worksheets/0Ar0dMoySp13UdEtNYTZpcFNzVkYwWmMtUXRiVUJXVVE/private/full/od6'/><link rel='edit' type='application/atom+xml' href='https://spreadsheets.google.com/feeds/worksheets/0Ar0dMoySp13UdEtNYTZpcFNzVkYwWmMtUXRiVUJXVVE/private/full/od6/d685wj0a34'/><gs:rowCount>94</gs:rowCount><gs:colCount>20</gs:colCount></entry><entry><id>https://spreadsheets.google.com/feeds/worksheets/0Ar0dMoySp13UdEtNYTZpcFNzVkYwWmMtUXRiVUJXVVE/private/full/od7</id><updated>2012-05-24T07:52:50.024Z</updated><category scheme='http://schemas.google.com/spreadsheets/2006' term='http://schemas.google.com/spreadsheets/2006#worksheet'/><title type='text'>Blad2</title><content type='text'>Blad2</content><link rel='http://schemas.google.com/spreadsheets/2006#listfeed' type='application/atom+xml' href='https://spreadsheets.google.com/feeds/list/0Ar0dMoySp13UdEtNYTZpcFNzVkYwWmMtUXRiVUJXVVE/od7/private/full'/><link rel='http://schemas.google.com/spreadsheets/2006#cellsfeed' type='application/atom+xml' href='https://spreadsheets.google.com/feeds/cells/0Ar0dMoySp13UdEtNYTZpcFNzVkYwWmMtUXRiVUJXVVE/od7/private/full'/><link rel='http://schemas.google.com/visualization/2008#visualizationApi' type='application/atom+xml' href='https://spreadsheets.google.com/tq?key=0Ar0dMoySp13UdEtNYTZpcFNzVkYwWmMtUXRiVUJXVVE&amp;sheet=od7'/><link rel='self' type='application/atom+xml' href='https://spreadsheets.google.com/feeds/worksheets/0Ar0dMoySp13UdEtNYTZpcFNzVkYwWmMtUXRiVUJXVVE/private/full/od7'/><link rel='edit' type='application/atom+xml' href='https://spreadsheets.google.com/feeds/worksheets/0Ar0dMoySp13UdEtNYTZpcFNzVkYwWmMtUXRiVUJXVVE/private/full/od7/0'/><gs:rowCount>100</gs:rowCount><gs:colCount>20</gs:colCount></entry></feed>";
		var xml = Xml.parse(xmlWorksheet).firstElement ();
		var entries = xml.elementsNamed('entry');
		var a = new Array<SheetInfo>();
		for (entry in entries) {
			var idElement = entry.elementsNamed('id').next();
			var idString = idElement.firstChild().toString();			
			var id = Tools.stringAfterLast(idString, '/');
			var id = idString.afterLast('/');
			var rowCount = Std.parseInt(entry.getElementContent('gs:rowCount') );
			var colCount = Std.parseInt(entry.getElementContent('gs:colCount') );
			var title = entry.getElementContent('title');
			
			a.push( {
				id:id,
				key:key,
				title:title,
				rows:rowCount,
				cols:colCount,
				listfeedUrl:'https://spreadsheets.google.com/feeds/list/key/worksheetId/private/full'.replace('key', key).replace('worksheetId', id),
				cellfeedUrl:'https://spreadsheets.google.com/feeds/cells/key/worksheetId/private/full'.replace('key', key).replace('worksheetId', id),				
			});
		}
		return a;
	}
	
	
	static public function getRowsInfo(authToken:String, xmlRows:String, listfeedUrl:String) {
		var xml = Xml.parse(xmlRows).firstElement ();
		var entries = xml.elementsNamed('entry');
		for (entry in entries) {
			
			
		}
	}

	static public function getCellsInfo(xmlCells:String) {
		var xml = Xml.parse(xmlCells).firstElement ();
		var entries = xml.elementsNamed('entry');
		var rows = new Rows();
		for (entry in entries) {
			var text = entry.getElementContent('gs:cell');
			var row = Std.parseInt(entry.getElementAttrValue('gs:cell', 'row'))-1;
			var col = Std.parseInt(entry.getElementAttrValue('gs:cell', 'col'))-1;
			if (rows[row] == null) rows[row] = new Cols();
			rows[row][col] = text;
		}
		trace(rows);
	}
	
	static public function addSheetRow(authToken:String, listFeedUrl:String, rowData:Hash<String>) {
		var proc = new Process ("curl", [
			'--header',
			'Content-Type: application/atom+xml',
			'--header', 
			"Authorization: GoogleLogin auth=" + authToken, 
			listFeedUrl,
			'--data',
			createRowDataEntry(rowData),
			'-k'
		]);			

		var lines = new Array<String>();
		try  {
			while (true) {
				var line = proc.stdout.readLine ();
				lines.push(line);
			}
		} catch (e:Dynamic) { };
		proc.close();			
		return lines.shift();		
	}
	
	static public function createRowDataEntry(rowData:Hash<String>) {		
		var result = "<entry xmlns='http://www.w3.org/2005/Atom' xmlns:gsx='http://schemas.google.com/spreadsheets/2006/extended'>";
		for (key in rowData.keys()) {
			result += "<gsx:" + key + ">" + rowData.get(key) + "</gsx:" + key + ">";			
		}
		result += "</entry>";	
		return result;
	}
	
	static public function getCellChangeEntry(key:String, sheetId:String, row:Int, col:Int, text:String) {
		var entry = "<entry xmlns='http://www.w3.org/2005/Atom' xmlns:gs='http://schemas.google.com/spreadsheets/2006'><id>https://spreadsheets.google.com/feeds/cells/[key]/[worksheetId]/private/full/R[row]C[col]</id><link rel='edit' type='application/atom+xml' href='https://spreadsheets.google.com/feeds/cells/[key]/[worksheetId]/private/full/R[row]C[col]'/><gs:cell row='[row]' col='[col]' inputValue='[text]'/></entry>";
		var result = buildCellUrl(entry, key, sheetId, row, col);		
		result = result.replace('[text]', text);
		return result;
	}
	
	static public function getCellFeedUrl(key:String, sheetId:String, row:Int, col:Int) {
		var result = buildCellUrl('https://spreadsheets.google.com/feeds/cells/[key]/[worksheetId]/private/full/R[row]C[col]', key, sheetId, row, col); // 'https://spreadsheets.google.com/feeds/cells/[key]/[worksheetId]/private/full/R[row]C[col]4'.replace('[key]', key).replace('[worksheetId]', sheetId).replace('[row]', Std.string(row)).replace('[col]', Std.string(col));
		return result;
	}	
	
	static public function updateCell(authToken:String, cellFeedUrl:String, cellChangeEntry:String) {
		
		/*
		var curldata = [
			'--header',
			'"Content-Type: application/atom+xml"',
			'--header', 
			'"Authorization: GoogleLogin auth=' + authToken + '"', 
			'"' + cellFeedUrl + '"',
			'--data',
			'"' + cellChangeEntry + '"',
			'-k'
		];
		*/
		
		
		//curl -X PUT --header "If-Match: *" --header "Content-Type: application/atom+xml" --header "Authorization: GoogleLogin auth=DQAAAMQAAADFhOHXJZxZcU_ZuG4ueubdMZK3a7MH7eVSxUZggvRU_PYidam13NlXKk1I--_nA2wvrqrxtMtBvudrL_lIMA8M0WFsa0gWpccHMLz2wAunlbModFRAoWbYikGGmQOwnSuoDMS6xxx_rf5VgVS4avntT45-8HnBVxnCEJy3TRtqOUQ96vTy2mgC73gFsHa45iQoHdzEyoAa_9sj9t19opbqYNpK1oo5WRJfAJa0aNif7Ac3XxpaksMNZLK3FBKaTemCV3P8mjGMUfKczjMlupw6" "https://spreadsheets.google.com/feeds/cells/0Ar0dMoySp13UdEtNYTZpcFNzVkYwWmMtUXRiVUJXVVE/od6/private/full/R1C2" --data "<entry xmlns='http://www.w3.org/2005/Atom' xmlns:gs='http://schemas.google.com/spreadsheets/2006'><id>https://spreadsheets.google.com/feeds/cells/0Ar0dMoySp13UdEtNYTZpcFNzVkYwWmMtUXRiVUJXVVE/od6/private/full/R1C2</id><link rel='edit' type='application/atom+xml' href='https://spreadsheets.google.com/feeds/cells/0Ar0dMoySp13UdEtNYTZpcFNzVkYwWmMtUXRiVUJXVVE/od6/private/full/R1C2'/><gs:cell row='1' col='2' inputValue='[text]'/></entry>" -k
		//-X PUT --header "If-Match: *" --header "Content-Type: application/atom+xml" --header "Authorization: GoogleLogin auth=DQAAAMQAAADFhOHXJZxZcU_ZuG4ueubdMZK3a7MH7eVSxUZggvRU_PYidam13NlXKk1I--_nA2wvrqrxtMtBvudrL_lIMA8M0WFsa0gWpccHMLz2wAunlbModFRAoWbYikGGmQOwnSuoDMS6xxx_rf5VgVS4avntT45-8HnBVxnCEJy3TRtqOUQ96vTy2mgC73gFsHa45iQoHdzEyoAa_9sj9t19opbqYNpK1oo5WRJfAJa0aNif7Ac3XxpaksMNZLK3FBKaTemCV3P8mjGMUfKczjMlupw6" "https://spreadsheets.google.com/feeds/cells/0Ar0dMoySp13UdEtNYTZpcFNzVkYwWmMtUXRiVUJXVVE/od6/private/full/R1C2" --data "<entry xmlns='http://www.w3.org/2005/Atom' xmlns:gs='http://schemas.google.com/spreadsheets/2006'><id>https://spreadsheets.google.com/feeds/cells/0Ar0dMoySp13UdEtNYTZpcFNzVkYwWmMtUXRiVUJXVVE/od6/private/full/R1C2</id><link rel='edit' type='application/atom+xml' href='https://spreadsheets.google.com/feeds/cells/0Ar0dMoySp13UdEtNYTZpcFNzVkYwWmMtUXRiVUJXVVE/od6/private/full/R1C2'/><gs:cell row='1' col='2' inputValue='[text]'/></entry>" -k
		
		//return curldata;
		
		
		var proc = new Process ("curl", [
			'-X', 
			'PUT', 
			'--header', 
			'If-Match: *',
			'--header',
			'Content-Type: application/atom+xml',
			'--header', 
			"Authorization: GoogleLogin auth=" + authToken, 
			cellFeedUrl,
			'--data',
			cellChangeEntry,
			'-k'
		]);			

		var lines = new Array<String>();
		try  {
			while (true) {
				var line = proc.stdout.readLine ();
				lines.push(line);
			}
		} catch (e:Dynamic) { };
		proc.close();			
		return lines.shift();
		
	}	
	

	
	static private function buildCellUrl(str:String, key:String, sheetId:String, row:Int, col:Int) {
		var result = str.replace('[key]', key).replace('[worksheetId]', sheetId).replace('[row]', Std.string(row)).replace('[col]', Std.string(col));
		return result;
	}
	
	
	
}

typedef SheetInfo = {
	key:String,
	id: String,
	title:String,
	rows:Int,
	cols:Int,
	listfeedUrl:String,
	cellfeedUrl:String,	
}


typedef Cols = Array<String>;
typedef Rows = Array<Cols>;
	
	
	


package cx;

/**
 * ...
 * @author Jonas Nyström
 */

 /*
class Main {	
	static var email = 'jonasnys';
	static var passwd = '%gloria!';
	static var keyTestSheet = '0Ar0dMoySp13UdE93Vno1QlJ3cklrLW5zTWItOTRZS2c';
	
	static function main() {
		var gs = new cx.GoogleTools.Spreadsheet(email, passwd, keyTestSheet);
		trace(gs.getCells());
	}		
} 
*/
import haxe.Http; 
import neko.io.Process;
class GoogleTools 
{
	private static var urlClientLogin = 'https://www.google.com/accounts/ClientLogin';
	
	static public function getAuthToken(email:String, password:String, ?service:String = 'wise'): String {
		var authToken = '';
		var http = new Http(urlClientLogin);
		http.setParameter('Email', email);
		http.setParameter('Passwd', password);
		http.setParameter('accountType', 'HOSTED_OR_GOOGLE');
		http.setParameter('source', 'service test');
		http.setParameter('service', service);		
		http.onError = function(msg:String) { trace(msg); }
		http.onData = function (data:String) {
			var a = data.split('Auth=');		
			authToken = a.pop();						
		}
		http.request(false);
		return authToken;
	}
	
	
	static public function getAuthorizedHttp(authToken:String, url:String): Http {
		var http = new Http(url);
		var tokenHeader = 'GoogleLogin Auth=' + authToken;
		http.setHeader('Authorization', tokenHeader);
		return http;
	}	
	
}


import haxe.Http;

/**
 * ...
 * @author Jonas Nyström
 */

using StringTools;

class Spreadsheet 
{
	private var key:String;
	private var authToken:String;
	private var worksheetLinks:WorksheetLinks;
	private var pageNumber:Int;
	
	public function new(email:String, passwd:String, key:String, ?pageNumber=0) {
		this.key = key;		
		this.pageNumber = pageNumber;
		this.authToken = GoogleTools.getAuthToken(email, passwd);
		this.worksheetLinks = _getWorksheetLinks(this.authToken, this.key, this.pageNumber);
	}
	
	private static var urlClientLogin = 'https://www.google.com/accounts/ClientLogin';
	
	public function getWorksheetLinks() {
		return this.worksheetLinks;
	}
	
	
	/*
	private function getAuthToken(email:String, password:String, ?service:String = 'wise'): String {
		var authToken = '';
		var http = new Http(urlClientLogin);
		http.setParameter('Email', email);
		http.setParameter('Passwd', password);
		http.setParameter('accountType', 'HOSTED_OR_GOOGLE');
		http.setParameter('source', 'service test');
		http.setParameter('service', service);		
		http.onError = function(msg:String) { trace(msg); }
		http.onData = function (data:String) {
			var a = data.split('Auth=');		
			authToken = a.pop();						
		}
		http.request(false);
		return authToken;
	}
	
	private function getAuthorizedHttp(authToken:String, url:String): Http {
		var http = new Http(url);
		var tokenHeader = 'GoogleLogin Auth=' + authToken;
		http.setHeader('Authorization', tokenHeader);
		return http;
	}
	*/
	
	public function getAuthToken() {
		return this.authToken;
	}
	
	public function getAuthorizedHttp(url:String): Http {
		var http = new Http(url);
		var tokenHeader = 'GoogleLogin Auth=' + this.authToken;
		http.setHeader('Authorization', tokenHeader);
		return http;
	}	
	
	
	public function _getWorksheetLinks(authToken:String, key:String, pageNumber:Int=0): WorksheetLinks {
		var urlWorksheet = 'https://spreadsheets.google.com/feeds/worksheets/KEY/private/full'.replace('KEY', key);
		var worksheetLinks:WorksheetLinks = {
			listLink:null,
			cellLink:null,
		}
		var http = GoogleTools.getAuthorizedHttp(authToken, urlWorksheet);
		http.onError = function(msg:String) { trace(msg); }
		http.onData = function(data:String) { 
			
			var xmlFeed = Xml.parse(data).firstElement();
			var xmlFirstEntry = ArrayTools.fromIterator(xmlFeed.elementsNamed('entry'))[pageNumber];
			
			var xmlEntryLinks = ArrayTools.fromIterator(xmlFirstEntry.elementsNamed('link'));
			worksheetLinks.listLink =  xmlEntryLinks[0].get('href');
			worksheetLinks.cellLink =  xmlEntryLinks[1].get('href');
		};
		http.request(false);	
		return worksheetLinks;
	}
	
	private function getWorksheetCells(authToken:String, cellLink:String): WorksheetCells {
		var cells = new WorksheetCells();
		var http = GoogleTools.getAuthorizedHttp(authToken, cellLink);
		http.onError = function(msg:String) { trace(msg); }
		http.onData = function(data:String) { 
			var xmlListFeed = Xml.parse(data).firstElement();
			var xmlEntries = ArrayTools.fromIterator(xmlListFeed.elementsNamed('entry'));
			for (entry in xmlEntries) {
				var cell = ArrayTools.fromIterator(entry.elementsNamed('gs:cell'))[0];
				var text = cell.get('inputValue');
				var row = Std.parseInt(cell.get('row'))-1;
				var col = Std.parseInt(cell.get('col'))-1;
				
				if (cells[row] == null) cells[row] = new Array<String>();
				cells[row][col] = text;
			}
		};
		http.request(false);			
		return cells;		
	}	
	
	//-----------------------------------------------------------------
	
	public function getCells(): WorksheetCells {
		return this.getWorksheetCells(this.authToken, this.worksheetLinks.cellLink);	
	}
	
	
	//-----------------------------------------------------------------------------------------------------
	
	public function addListRow() {
		trace(this.authToken);
		trace(this.worksheetLinks.listLink);
		var post = '<entry xmlns="http://www.w3.org/2005/Atom" xmlns:gsx="http://schemas.google.com/spreadsheets/2006/extended"> <gsx:a>1</gsx:a> <gsx:b>1</gsx:b> </entry>';
		
		var proc = new Process('curl', 
		[
			'--header',
			"Content-Type: application/atom+xml",
			'--header',
			//"Authorization: GoogleLogin auth=DQAAAMMAAAC3oSF9vqfh_M6o_bhCZ7XtrsSNnpM05Y8MLNeU7QppeoG57HwxYp2mE7OHCRe_FHNecytKIHXF7xPwLFn-TM12qXkknrr_AqtThQ4R0eJYEgZBg6TqOke1D2bpeYe2KZKrW87S2gZTnn9EcFi9t2fhdB9lpoqZPkGBoFo7A59Pw_ACTHoMOzihn_ATKSQrql_NwYQ559wCc2_EoCF2TTNHIsqBq8yYRqJTPwdyEsfjiV6q0SFtHkywrZZP0UshioaLStE1oAOTMX-AJNuug8Dy",
			"Authorization: GoogleLogin auth=" + authToken,
			//"https://spreadsheets.google.com/feeds/list/0Ar0dMoySp13UdEtNYTZpcFNzVkYwWmMtUXRiVUJXVVE/od6/private/full",
			this.worksheetLinks.listLink,
			'--data',
			"<entry xmlns='http://www.w3.org/2005/Atom' xmlns:gsx='http://schemas.google.com/spreadsheets/2006/extended'> <gsx:a>1</gsx:a> <gsx:b>1</gsx:b> </entry>",
			'-k'
		]);
		
		try  {
			while (true) {
				var line = proc.stdout.readLine ();
				trace(line);
			}
		} catch (e:Dynamic) { };
		proc.close();			
		
		
	}
	
}

typedef WorksheetLinks = {
	listLink:String,
	cellLink:String,
}

typedef WorksheetCells = Array<Array<String>>;


class Documents  {
	
	
	private var authToken:String;
	private var email:String;
	private var passwd:String;
	
	
	public function new(email:String, passwd:String) {		
		//var authToken = GoogleTools.getAuthToken('jonasnys', '%gloria!', 'writely');
		this.email = email;
		this.passwd = passwd;
	}
	
	private function getAuthToken(email:String, passwd:String) {
		if (this.authToken != null) return this.authToken;
		this.authToken = GoogleTools.getAuthToken(email, passwd, 'writely');
		return this.authToken;
	}
	
	
	private var documentEntries:Hash<DocumentEntry>;
	public function getDocumentEntries():Hash<DocumentEntry> {
		if (this.documentEntries != null) return this.documentEntries;
		
		var urlDocumentList:String = 'https://docs.google.com/feeds/documents/private/full';		
		var http = GoogleTools.getAuthorizedHttp(this.getAuthToken(this.email, this.passwd), urlDocumentList);				
		http.onError = function(msg:String) { trace(msg); }
		http.onData = function(data:String) { 
			this.documentEntries = _getDocumentEntries(data);
		};
		http.request(false);				
		return this.documentEntries;
	}
	
	public function getTitles(): Array<String> {
		var ret = ArrayTools.fromIterator(this.getDocumentEntries().keys());
		ret.sort(function(a, b) { return Reflect.compare(a, b); } );
		return ret;
	}
	
	static private function _getDocumentEntries(xmlDocumentList:String):Hash<DocumentEntry> {		
		var ret = new Hash<DocumentEntry>();		
		var xml = Xml.parse(xmlDocumentList);		
		var xmlFeed = xml.firstElement();		
		var entries = xmlFeed.elementsNamed('entry');
		//var i = 0;
		for (entry in entries) {
			//if (i > 5) break;
			
			var documentEntry:DocumentEntry = { id:null, title:null };
			for (el in entry.elements()) {
				if (el.nodeName == 'id') documentEntry.id = Tools.stringAfterLast(el.firstChild().toString(), '%3A');
				if (el.nodeName == 'title') documentEntry.title = el.firstChild().toString();
			}
			ret.set(documentEntry.title, documentEntry);
			//i++;			
		}
		return ret;		
	}	
	
	public function getDownloadUrl(id:String, format:String) {
		//var url = 'https://docs.google.com/feeds/download/documents/Export?docID=' + id + '&exportFormat=' + format;
		var url = 'https://docs.google.com/feeds/download/documents/Export?exportFormat=' + format + '&id=' + id;
		return url;
	}
	
	public function getDocumentDownloadString(id:String, format:String):String {		
		var url = getDownloadUrl(id, format);		
		//trace(this.authToken);
		//trace(url);
		//var url = "https://docs.google.com/feeds/download/documents/Export?exportFormat=html&id=1GE6UfrAPNMikaFfBJHIBoLg2yNM4Dke3EwBkF9ZMlSk";
		//trace(url);
		var ret:String = null;
		
		var http = GoogleTools.getAuthorizedHttp(this.getAuthToken(this.email, this.passwd), url);
		http.onError = function(msg:String) { trace(msg); }
		http.onData = function(data:String) { 
			//trace(data.length);
			ret = data;		
			//FileTools.putContent('link.txt', ret);
		};
		http.request(false);					
		
		return ret;		
	}
	
	public function saveDocumentToOdt(id:String, filename:String) {
		var dataString = this.getDocumentDownloadString(id, 'odt');
		FileTools.putBinaryContent(filename, dataString);		
	}
	
	public function saveDocumentToHtml(id:String, filename:String) {
		var string = this.getDocumentDownloadString(id, 'html');
		FileTools.putContent(filename, string);
	}
	
	public function getEntryForTitle(titleSearch:String):DocumentEntry {		
		var entries = this.getDocumentEntries();
		for (entry in entries) {
			if (entry.title.toLowerCase() == titleSearch.toLowerCase()) return entry; 
		}
		return null;
	}
	
	public  function getCleanHtml(content:String): String {
		
		content = HtmlTools.closeImageTags(content);
		content = HtmlTools.closeHrTags(content);
		
		var xml = Xml.parse(content).firstElement();
		var bodyXml = XmlTools.getFirstElement (xml, 'body');
		bodyXml.remove('class');		
		var elements = bodyXml.elements();
		for (element in elements) {
			element.remove('class');	
			for (el in element.elements()) {
				el.remove('class');
			}
			if (element.nodeName == 'table') {
				element.set('width', '100%');
			}
		}
		var bodyString = bodyXml.toString();
		bodyString = StringTools.replace(bodyString, '<span>', '');
		bodyString = StringTools.replace(bodyString, '</span>', '');
		bodyString = StringTools.replace(bodyString, '<hr>', '<hr/>');
		bodyString = StringTools.replace(bodyString, '**', '<b>');
		bodyString = StringTools.replace(bodyString, '##', '<i>');
		bodyString = StringTools.replace(bodyString, '/*', '</b>');
		bodyString = StringTools.replace(bodyString, '/#', '</i>');
		bodyString = StringTools.replace(bodyString, 'http://', '');
		
		return bodyString;
	}
	
}

typedef DocumentEntry = {
	id:String,
	title:String,	
}


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
 
class GoogleTools 
{

	
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
		this.authToken = getAuthToken(email, passwd);
		this.worksheetLinks = getWorksheetLinks(this.authToken, this.key, this.pageNumber);
	}
	
	private static var urlClientLogin = 'https://www.google.com/accounts/ClientLogin';
	
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
	
	private function getWorksheetLinks(authToken:String, key:String, pageNumber:Int=0): WorksheetLinks {
		var urlWorksheet = 'https://spreadsheets.google.com/feeds/worksheets/KEY/private/full'.replace('KEY', key);
		var worksheetLinks:WorksheetLinks = {
			listLink:null,
			cellLink:null,
		}
		var http = getAuthorizedHttp(authToken, urlWorksheet);
		http.onError = function(msg:String) { trace(msg); }
		http.onData = function(data:String) { 
			
			var xmlFeed = Xml.parse(data).firstElement();
			var xmlFirstEntry = Iterators.array(xmlFeed.elementsNamed('entry'))[pageNumber];
			
			var xmlEntryLinks = Iterators.array(xmlFirstEntry.elementsNamed('link'));
			worksheetLinks.listLink =  xmlEntryLinks[0].get('href');
			worksheetLinks.cellLink =  xmlEntryLinks[1].get('href');
		};
		http.request(false);	
		return worksheetLinks;
	}
	
	private function getWorksheetCells(authToken:String, cellLink:String): WorksheetCells {
		var cells = new WorksheetCells();
		var http = getAuthorizedHttp(authToken, cellLink);
		http.onError = function(msg:String) { trace(msg); }
		http.onData = function(data:String) { 
			var xmlListFeed = Xml.parse(data).firstElement();
			var xmlEntries = Iterators.array(xmlListFeed.elementsNamed('entry'));
			for (entry in xmlEntries) {
				var cell = Iterators.array(entry.elementsNamed('gs:cell'))[0];
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
	
}

typedef WorksheetLinks = {
	listLink:String,
	cellLink:String,
}

typedef WorksheetCells = Array<Array<String>>;
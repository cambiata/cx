package cx3.google;
import haxe.Http;
import neko.io.Process;
import neko.Utf8;

/**
 * ...
 * @author Jonas Nyström
 */
using StringTools;
class GoogleSheet extends GoogleBase
{

	private var key:String;
	private var pageNumber:Int;
	private var worksheetLinks:WorksheetLinks;
	private var worksheetCells:WorksheetCells;
	
	public function new(email:String, passwd:String, key:String, ?pageNumber=0) {
		this.key = key;		
		this.pageNumber = pageNumber;
		super(email, passwd, 'wise');
		this.worksheetLinks = _getWorksheetLinks(this.authToken, this.key, this.pageNumber);
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
			var xmlFirstEntry = Iterators.array(xmlFeed.elementsNamed('entry'))[pageNumber];
			
			var xmlEntryLinks = Iterators.array(xmlFirstEntry.elementsNamed('link'));
			worksheetLinks.listLink =  xmlEntryLinks[0].get('href');
			worksheetLinks.cellLink =  xmlEntryLinks[1].get('href');
		};
		http.request(false);	
		return worksheetLinks;
	}	
	
	public function getWorksheetLinks() {
		return this.worksheetLinks;
	}
	
	public function addListRow() {
		
		
		var auth = 	"Authorization: GoogleLogin auth=DQAAAMMAAAC3oSF9vqfh_M6o_bhCZ7XtrsSNnpM05Y8MLNeU7QppeoG57HwxYp2mE7OHCRe_FHNecytKIHXF7xPwLFn-TM12qXkknrr_AqtThQ4R0eJYEgZBg6TqOke1D2bpeYe2KZKrW87S2gZTnn9EcFi9t2fhdB9lpoqZPkGBoFo7A59Pw_ACTHoMOzihn_ATKSQrql_NwYQ559wCc2_EoCF2TTNHIsqBq8yYRqJTPwdyEsfjiV6q0SFtHkywrZZP0UshioaLStE1oAOTMX-AJNuug8Dy";
		var auth2 = "Authorization: GoogleLogin auth=" + this.authToken;
		
		trace(auth.length);
		trace(auth2.length);
		
		var proc = new Process('curl', 
		[
			'--header',
			"Content-Type: application/atom+xml",
			'--header',
			auth2,
			//auth,
			//"https://spreadsheets.google.com/feeds/list/" + this.key + "/od6/private/full",
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



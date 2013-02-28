package g2;
import haxe.Http;
import haxe.xml.Fast;

/**
 * ...
 * @author Jonas Nyström
 */
class G2Tools
{
	static private var onData: String->Void;
	static private var onError: String->Void;

	public function new() { }
	/**
	  	var g2 = new G2Tools();
	 	g2.onData = function(data) {
	 		FileTools.putContent('g2.xml', data);
	 		xmlData = data;
	 	}
	 	g2.getData();		
	 */
	
	static public function getArrangemang(onData: String->Void, onError: String->Void = null) {	
		var postData = '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/"><s:Body><GetArrangemang xmlns="http://tempuri.org/"/></s:Body></s:Envelope>';
		var soapAction = "http://tempuri.org/GustavExportSensusArrangemang/GetArrangemang";
		getData(postData, soapAction, onData, onError);
	}
	 
	static public function getScorxPersoner(onData: String->Void, onError: String->Void = null) {		
		var postData = '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/"><s:Body><GetDeltagareForScorx xmlns="http://tempuri.org/"/></s:Body></s:Envelope>';
		var soapAction = "http://tempuri.org/GustavExportSensusArrangemang/GetDeltagareForScorx";
		getData(postData, soapAction, onData, onError);
		/*
		var url = 'http://193.15.92.32:81/GustavSensusExport.svc';
		var http = new Http(url);
		http.setPostData(postData);		
		http.setHeader('Content-Type', "text/xml; charset=utf-8");
		http.setHeader('SOAPAction', "http://tempuri.org/GustavExportSensusArrangemang/GetDeltagareForScorx");
		http.onData = (onData != null) ? onData : onDataDefault;	
		http.onError = (onError != null) ? onError : onErrorDefault;
		http.request(true);
		*/
	}
	
	static private function getData(postData:String, soapAction:String, onData: String->Void, onError: String->Void = null) {		
		var url = 'http://193.15.92.32:81/GustavSensusExport.svc';
		var http = new Http(url);
		http.setPostData(postData);		
		http.setHeader('Content-Type', "text/xml; charset=utf-8");
		http.setHeader('SOAPAction', soapAction);
		http.onData = (onData != null) ? onData : onDataDefault;	
		http.onError = (onError != null) ? onError : onErrorDefault;
		http.request(true);		
	}
	
	static private function onDataDefault(data) {
		throw "G2Users.onData should be replaced!";
	}
	
	static private function onErrorDefault(error) {
		trace(error);
		throw "G2Users.onError should be replaced!";
	}
	
	//---------------------------------------------------------------------------
	
	static public function getUsersFromG2Xml(xml:Xml): GUsers {
		var personer = xml.firstElement().firstElement().firstElement().firstElement().elements();		
		var users:GUsers = [];
		for (person in personer) {			
			var user:GUser = { };
			user.lastname = person.elementsNamed("a:Efternamn").next().firstChild().nodeValue; 
			user.firstname = person.elementsNamed("a:Fornamn").next().firstChild().nodeValue; 
			user.email = person.elementsNamed("a:Epost").next().firstChild().nodeValue; 
			user.last4 = person.elementsNamed("a:LastFour").next().firstChild().nodeValue; 
			user.id = person.elementsNamed("a:Personnummer").next().firstChild().nodeValue; 
			users.push(user);
		}		
		return users;		
	}
	
	static public function getUsersFromG1Xml(xml:Xml): GUsers {
		var users:GUsers = [];
		var oldFast:Fast = new Fast(xml.firstElement());
		var items = oldFast.node.userstoadd.nodes.User;		
		var user:GUser = { };	
		for (item in items) {			
			user.firstname = item.att.fnamn;
			user.lastname = item.att.enamn;
			user.email = item.att.email;
			user.last4 = item.att.password;
			user.id = null;
			users.push(user);
		}		
		return users;
	}
	
	static public function getArrFromXml(xml:Xml):GArrs {
		var arrs = xml.firstElement().firstElement().firstElement().firstElement().elements();	
		var arrangemangs:GArrs = [];
		for (arr in arrs) {			
			var arrangemang:GArr = { };
			arrangemang.amne 			= arr.elementsNamed("a:amne").next().firstChild().nodeValue;
			arrangemang.arrangemang 	= arr.elementsNamed("a:arrangemang").next().firstChild().nodeValue;
			arrangemang.arrid 			= Std.parseInt(arr.elementsNamed("a:arrid").next().firstChild().nodeValue);
			arrangemang.arrnr 			= Std.parseInt(arr.elementsNamed("a:arrnr").next().firstChild().nodeValue);
			var elLedare = arr.elementsNamed("a:ledare").next();
			arrangemang.ledare = (elLedare.get('i:nil') != 'true') ? arr.elementsNamed("a:ledare").next().firstChild().nodeValue : null;
			arrangemangs.push(arrangemang);
		}
		return arrangemangs;
		
	}
	
}


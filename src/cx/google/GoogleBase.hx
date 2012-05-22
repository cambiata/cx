package cx.google;

import haxe.Http; 

/**
 * ...
 * @author Jonas Nyström
 */

class GoogleBase 
{
	private static var URL_CLIENT_LOGIN = 'https://www.google.com/accounts/ClientLogin';
	
	private var authToken:String;
	
	public function new(email:String, password:String, ?service:String = 'wise') {
		this._getAuthToken(email, password, service);
	}
	
	private function _getAuthToken(email:String, password:String, ?service:String = 'wise'): String {
		var authToken = '';
		var http = new Http(URL_CLIENT_LOGIN);
		http.setParameter('Email', email);
		http.setParameter('Passwd', password);
		http.setParameter('accountType', 'HOSTED_OR_GOOGLE');
		http.setParameter('source', 'service_test');
		http.setParameter('service', service);		
		http.onError = function(msg:String) { trace(msg); }
		http.onData = function (data:String) {
			var a = data.split('Auth=');		
			authToken = a.pop();						
		}
		http.request(false);
		this.authToken = authToken;
		return this.authToken;
	}	
	
	public function getAuthorizedHttp(url:String): Http {
		if (this.authToken == null) throw "No AuthToken!";
		
		var http = new Http(url);
		var tokenHeader = 'GoogleLogin Auth=' + this.authToken;
		http.setHeader('Authorization', tokenHeader);
		return http;
	}		
	
	public function getAuthToken() {
		return this.authToken;
	}
	
	public function getCurlAuhtorized(url:String) {
		return 'curl --header "Authorization: GoogleLogin auth=' + this.authToken + '" "' + url + '" -k';
	}
}
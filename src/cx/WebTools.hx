package cx;

using StringTools;

class WebTools {
	
	
	
	static public function stripBaseDirAndIndexFile(uri:String, baseDir:String, indexFile:String) {
		return uri.replace(baseDir, '').replace(indexFile, '').replace('//', '');	
	}
	
	static public function getHostName() {
		return Web.getHostName();
	}
	
	
	static public function getDomainInfo() {		
		var hostname = neko.Web.getHostName();
		return domainparts(hostname);
	}
	
	static public function domainparts(hostname:String) {
		var parts = hostname.split('.');		
		if (parts.length == 1) parts.push('');
		if (parts.length == 2) parts.unshift('');				
		
		// HACK!
		if (parts[0] == 'dev') parts[0] = '';
		
		return {
			topdomain: parts[2],
			maindomain: parts[1],
			subdomain: parts[0],
			subMain: (parts[0] > '') ? parts[0] + '.' + parts[1] : parts[1],
			mainTop: (parts[2] > '') ? parts[1] + '.' + parts[2] : parts[1],
		}
	}
	
	
	
	static public function getUri() {
		var uri = Web.getURI();
		if (uri.endsWith('/')) uri = uri.substr(0, uri.length - 1);
		return uri;
	}
	
	static public function getPostValue(key:String):String {
		var postdata = Web.getPostData();
		if (postdata == null) return null;
		var postdatas = postdata.split('&');
		
		for (pair in postdatas) {
			if (StringTools.startsWith(pair, key)) {
				return pair.split('=')[1];
			}
		}
		return null;
	}
	
	static public function slashToUnderscores(str:String): String {
		return str.replace('/', '_');
		
	}
	
	static public function underscoreToSlash(str:String): String {
		return str.replace('_', '/');
	}	
	
	
	
}
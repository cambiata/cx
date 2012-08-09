package cx;

using StringTools;

class WebTools {
	
	static public function stripBaseDirAndIndexFile(uri:String, baseDir:String, indexFile:String) {
		return uri.replace(baseDir, '').replace(indexFile, '').replace('//', '');	
	}
	
	static public function getDomainInfo() {		
		var hostname = neko.Web.getHostName();
		var parts = hostname.split('.');		
		if (parts.length == 1) parts.push('');
		if (parts.length == 2) parts.unshift('');				
		
		// HACK!
		if (parts[0] == 'dev') parts[0] = '';
		
		return {
			topdomain: parts[2],
			maindomain: parts[1],
			subdomain: parts[0],
			submain: (parts[0] > '') ? parts[0] + '.' + parts[1] : parts[1],
			maintop: (parts[2] > '') ? parts[1] + '.' + parts[2] : parts[1],
		}
	}
	
	static public function getUri() {
		return Web.getURI();
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
	
	
	
}
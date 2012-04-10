package cx;

using StringTools;

class WebTools {
	
	static public function stripBaseDirAndIndexFile(uri:String, baseDir:String, indexFile:String) {
		return uri.replace(baseDir, '').replace(indexFile, '').replace('//', '');	
	}
	
	
}
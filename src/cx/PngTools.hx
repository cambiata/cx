package cx;

/**
 * ...
 * @author Jonas Nyström
 */


class PngTools {	
	
	static public function toHtmlImg(pngFile:String) {
		var bytes = neko.io.File.getBytes(pngFile);		
		return pngBytesToHtmlImg(bytes);
	}
	
	static public function pngBytesToHtmlImg(pngBytes:haxe.io.Bytes, ?style:String='') {
		var string = pngBytes.toString();
		var BASE64:String = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
		var string64 = haxe.BaseCode.encode(string, BASE64);		
		var html = '<img style="' + style + '" src="data:image/png;base64,' + string64 + '" />';
		return html;
	}
	
}	

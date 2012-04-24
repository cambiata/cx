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
		var string64 = EncodeTools.base64Encode(string); 
		var html = '<img style="' + style + '" src="data:image/png;base64,' + string64 + '" />';
		return html;
	}
	
}	

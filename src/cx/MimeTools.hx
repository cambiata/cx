package cx;

/**
 * ...
 * @author Jonas Nyström
 */
class MimeTools
{
	static public function getMime(filename:String): String
	{
		var ext = FileTools.getExtension(filename);
		switch(ext)
		{
			case 'jpeg', 'jpg': return 'image/jpeg';
			case 'png': return 'image/png';
			case 'flv': return 'video/x-flv';			
			case 'mp3' : return 'audio/mpeg';
			case 'xml' : return 'application/xml';
			default: throw 'Mime type for $filename unknown!'; return 'unknown';
		}
	}
	
}
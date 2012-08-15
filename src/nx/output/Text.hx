package nx.output;
import cx.nme.display.utils.StringBitmap;
import nme.text.TextFormat;
import nme.display.Bitmap;
import nme.geom.Rectangle;

/**
 * ...
 * @author Jonas Nyström
 */

class Text 
{
	private var scaling:TScaling;
	private var stringBitmap:StringBitmap;
	private var rectCache:Hash<Rectangle>;
	
	/*
	 * *********************************************************
	 * CONSTRUCTOR
	 * *********************************************************
	 *
	*/
	
	public function new(scaling:TScaling, font:String='Times New Roman', size:Float=12, color:Int=0x000000, bold:Bool=false, italic:Bool=false) {
		this.scaling = scaling; 		
#if js
		var scalefactor:Float = 2.8;
#else
		var scalefactor:Float = 3.6;
#end		
		//var fontsize = scaling.fontScaling * (size / scaling.fontScaling) * scalefactor;
		var fontsize = scaling.fontScaling * scalefactor * 1.5;
		trace('fontsize' + fontsize);
		this.stringBitmap = new StringBitmap(font, fontsize, color, bold, italic);
		this.rectCache = new Hash<Rectangle>();
	}
	
	/*
	 * *********************************************************
	 * 
	 * *********************************************************
	 *
	*/	
	
	public function getStringBitmap(string:String, x:Float = 0, y:Float = 0, maxLength:Int=20 ):Bitmap {
		return this.stringBitmap.getStringBitmap(string, x, y, maxLength);		
	}
	
	public function getStringRect(string:String):Rectangle {		
		if (this.rectCache.exists(string)) return this.rectCache.get(string);
		var bmp:Bitmap = this.getStringBitmap(string);
		var r = new Rectangle(0, 0, bmp.width, bmp.height);
		this.rectCache.set(string, r);
		return r;		
	}

	static private var instance:Text;
	static public function getInstance():Text {
		if (instance != null) return instance;
		instance = new Text(Scaling.getNormal());
		return instance;
	}
	
}
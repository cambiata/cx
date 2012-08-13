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
	
	public function new(scaling:TScaling, font:String='Times New Roman', size:Int=20, color:Int=0x000000, bold:Bool=false, italic:Bool=false) {
		this.scaling = scaling; 
		
#if js
		var scalefactor:Float = 3.65;
#else
		var scalefactor:Float = 4.0;
#end
		
		var fontsize = scaling.fontScaling * (size / scaling.fontScaling) * scalefactor;
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

	
}
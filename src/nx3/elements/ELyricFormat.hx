package nx3.elements;

/**
 * ...
 * @author 
 */
enum ELyricFormat
{
	Bold;
	Italic;
	Format(fontName:String, size:Float, bold:Bool, Italic:Bool);
}
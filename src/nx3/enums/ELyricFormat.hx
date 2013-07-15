package nx3.enums;

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
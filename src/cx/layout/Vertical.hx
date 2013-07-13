package cx.layout;

/**
 * ...
 * @author 
 */
enum Vertical
{
	TOP;
	CENTER;
	BOTTOM;
	STRETCH;
	NONE;
	
	TOP_MARGIN(margin:Float);
	BOTTOM_MARGIN(margin:Float);
	STRETCH_MARGIN(topMargin:Float, BOTTOM_MARGIN:Float);
}
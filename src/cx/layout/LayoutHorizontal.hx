package cx.layout;

/**
 * ...
 * @author 
 */
enum LayoutHorizontal
{
	LEFT;
	CENTER;
	RIGHT;
	STRETCH;
	NONE;
	
	LEFT_MARGIN(margin:Float);
	RIGHT_MARGIN(margin:Float);
	STRETCH_MARGIN(leftMargin:Float, rightMargin:Float);	
}
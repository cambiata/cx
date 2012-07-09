package sx.type;

/**
 * ...
 * @author Jonas Nyström
 */

typedef TGridItem = {
	pos:Float,
	type:String,
	page:Int,
	x:Float,
	y:Float,
	width:Float,
	height:Float,
	/*
	xAbs:Int;
	yAbs:Int;
	widthAbs:Int;
	heightAbs:Int;
	*/
}
	
class GridItemFactory {
	
	static public function getNew(pos:Float, page:Int, type:String):TGridItem {
		
		var gi:TGridItem = {
			pos: pos,
			page: page,
			x: 0.1,
			y: 0.2,
			width: 0.8,
			height:0.3,
			type: type
			};
			
			return gi;
	}
	
}
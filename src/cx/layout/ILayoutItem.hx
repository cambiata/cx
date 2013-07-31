package cx.layout;

/**
 * ...
 * @author 
 */
interface ILayoutItem
{
	var manager:LayoutManager;
	function resize(stageWidth:Float, stageHeight:Float):Void;	
	dynamic function afterResize(x:Float, y:Float, width:Float, height:Float):Void;
}
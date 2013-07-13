package cx.layout;

/**
 * ...
 * @author 
 */
interface ILayoutItem
{
	var manager:LayoutManager;
	function resize(stageWidth:Float, stageHeight:Float):Void;
}
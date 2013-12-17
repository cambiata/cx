package cx.layout;
import flash.events.Event;
import flash.Lib;

/**
 * ...
 * @author 
 */
class LayoutManager
{
	var items:Array<ILayoutItem>;

	public function new(items:Array<ILayoutItem>=null) 
	{
		if (items == null) items = [];
		this.items = items;
		this.initOnResize_();
	}
	
	private function initOnResize_()
	{				
		Lib.current.stage.addEventListener(Event.RESIZE, onResize_);
	}
	
	private function onResize_(e:Event):Void 
	{
		var stageWidth = Lib.current.stage.stageWidth;
		var stageHeight = Lib.current.stage.stageHeight;
		//trace('Layout manager onResize ' + stageWidth + ' ' + stageHeight);
		doLayout_(stageWidth, stageHeight);
	}

	private function doLayout_(stageWidth:Float, stageHeight:Float)
	{
		for (item in items)
		{
			item.resize(stageWidth, stageHeight);
		}
	}
	
	public function resize(stageWidth:Float=0, stageHeight:Float=0)
	{
		stageWidth = (stageWidth == 0) ? Lib.current.stage.stageWidth : stageWidth;
		stageHeight = (stageHeight == 0) ? Lib.current.stage.stageHeight : stageHeight;
		doLayout_(stageWidth, stageHeight);
		
	}
	
	public function add(item:ILayoutItem)
	{
		this.items.push(item);
		item.manager = this;
	}
	
}
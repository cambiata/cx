package cx.layout;
import flash.display.Sprite;

/**
 * ...
 * @author 
 */
class UIManager extends Sprite
{
	var manager:LayoutManager;

	public function new() 
	{
		super();
		manager = new LayoutManager();		
	}
	
	public function addLayoutItems(items:Array<ILayoutItem>)
	{
		for (item in items) this.manager.add(item);
		manager.resize;		
	}
	
}
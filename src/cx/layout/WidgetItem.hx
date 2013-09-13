package cx.layout;
import cx.layout.ILayoutItem;
import cx.layout.Horizontal;
import cx.layout.LayoutManager;
import cx.layout.Vertical;
import ru.stablex.ui.widgets.Widget;

/**
 * ...
 * @author 
 */
class WidgetItem implements ILayoutItem
{
	public var manager:LayoutManager;
	public var target:Widget;
	public var horizontal:Horizontal;
	public var vertical:Vertical;
	


	public function new(target:Widget, horizontal:Horizontal=null, vertical:Vertical=null) 
	{
		//this.manager = manager; 
		this.target = target;
		this.horizontal = horizontal;
		this.vertical = vertical;
		
		//this.manager.addItem(this);
	}
	
	public function resize(stageWidth:Float, stageHeight:Float) : Void
	{
		var targetWidth = this.target.w;
		var targetHeight = this.target.h;
		
		var refresh:Bool = false;
		
		switch(this.horizontal) 
		{
			case Horizontal.LEFT:
				this.target.x = 0;
			case Horizontal.CENTER:
				this.target.x = (stageWidth - targetWidth) / 2;
			case Horizontal.RIGHT:
				this.target.x = stageWidth - targetWidth;
			case Horizontal.STRETCH:	
				this.target.x = 0;
				this.target.w = stageWidth;
				refresh = true;
			case Horizontal.NONE:
				
			case Horizontal.LEFT_MARGIN(margin):
				this.target.x = margin;
			case Horizontal.RIGHT_MARGIN(margin):
				this.target.x = stageWidth - targetWidth - margin;
			case Horizontal.STRETCH_MARGIN(leftMargin, rightMargin):
				this.target.x = leftMargin;
				this.target.w = stageWidth - leftMargin - rightMargin;					
				refresh = true;
		}		
		
		switch(this.vertical) 
		{
			case Vertical.TOP:
				this.target.y = 0;
			case Vertical.CENTER:
				this.target.y = (stageHeight - targetHeight) / 2;
			case Vertical.BOTTOM:
				this.target.y = stageHeight - targetHeight;
			case Vertical.STRETCH:	
				this.target.y = 0;
				this.target.h = stageHeight;
				refresh = true;
			case Vertical.NONE:
				
			case Vertical.TOP_MARGIN(margin):
				this.target.y = margin;
			case Vertical.BOTTOM_MARGIN(margin):
				this.target.y = stageHeight - targetHeight - margin;
			case Vertical.STRETCH_MARGIN(topMargin, bottomMargin):
				this.target.y = topMargin;
				this.target.h = stageHeight - topMargin - bottomMargin;				
				refresh = true;
		}			

		if (refresh) this.target.refresh();
	
		this.afterResize(target.x, target.y, target.w, target.h);
		
	}
	
	/* INTERFACE cx.layout.ILayoutItem */
	
	dynamic public function afterResize(x:Float, y:Float, width:Float, height:Float) 
	{
		
	}
	
	/* INTERFACE cx.layout.ILayoutItem */
	
	
}
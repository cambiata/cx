package cx.layout;
import cx.layout.LayoutManager;
import flash.display.Sprite;

/**
 * ...
 * @author 
 */
class LayoutSprite implements IResize
{
	public var manager:LayoutManager;
	public var target:Sprite;
	public var horizontal:LayoutHorizontal;
	public var vertical:LayoutVertical;

	public function new(manager:LayoutManager, target:Sprite, horizontal:LayoutHorizontal=null, vertical:LayoutVertical=null) 
	{
		this.manager = manager; 
		this.target = target;
		this.horizontal = horizontal;
		this.vertical = vertical;
		
		this.manager.addItem(this);
	}
	
	public function resize(stageWidth:Float, stageHeight:Float) : Void
	{	
		var targetWidth = this.target.width;
		var targetHeight = this.target.height;
		
		switch(this.horizontal) 
		{
			case LayoutHorizontal.LEFT:
				this.target.x = 0;
			case LayoutHorizontal.CENTER:
				this.target.x = (stageWidth - targetWidth) / 2;
			case LayoutHorizontal.RIGHT:
				this.target.x = stageWidth - targetWidth;
			case LayoutHorizontal.STRETCH:	
				this.target.x = 0;
				this.target.width = stageWidth;
			case LayoutHorizontal.NONE:
				
			case LayoutHorizontal.LEFT_MARGIN(margin):
				this.target.width = margin;
			case LayoutHorizontal.RIGHT_MARGIN(margin):
				this.target.x = stageWidth - targetWidth - margin;
			case LayoutHorizontal.STRETCH_MARGIN(leftMargin, rightMargin):
				this.target.x = leftMargin + leftMargin;
				this.target.width = stageWidth - leftMargin - rightMargin;								
		}		
		
		switch(this.vertical) 
		{
			case LayoutVertical.TOP:
				this.target.y = 0;
			case LayoutVertical.CENTER:
				this.target.y = (stageHeight - targetHeight) / 2;
			case LayoutVertical.BOTTOM:
				this.target.y = stageHeight - targetHeight;
			case LayoutVertical.STRETCH:	
				this.target.y = 0;
				this.target.height = stageHeight;
			case LayoutVertical.NONE:
				
			case LayoutVertical.TOP_MARGIN(margin):
				this.target.y = margin;
			case LayoutVertical.BOTTOM_MARGIN(margin):
				this.target.y = stageHeight - targetHeight - margin;
			case LayoutVertical.STRETCH_MARGIN(topMargin, bottomMargin):
				this.target.y = topMargin;
				this.target.height = stageHeight - topMargin - bottomMargin;
		}	
		
	}
	
}
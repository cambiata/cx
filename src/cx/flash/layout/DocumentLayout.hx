package cx.flash.layout;
import flash.display.DisplayObject;
import motion.Actuate;
import ru.stablex.ui.widgets.Widget;
//import ru.stablex.ui.widgets.Widget;

/**
 * ...
 * @author 
 */
class DocumentLayout
{
	static public  function arrange(holder:Widget, holderWidth:Float, childWidth:Float = 210, childHeight:Float = 297, tweenTime:Float=0.6 ) 
	{
		if (holder == null) throw "HOLDER == null";
		
		var wrapperWidth:Float = 0;
		var wrapperHeight:Float = 0;
		
		var margin:Float = 10.0;
		var childX = new Array<Float>();
		var childY = new Array<Float>();
		
		var currX: Float = margin;
		var currY: Float = margin;
		
		var numChildren = holder.numChildren;		
		
		for (i in 0...numChildren) 
		{
			//trace(currX);
			childX[i] = currX;
			childY[i] = currY;			
			currX += childWidth + margin;			
			if (currX + childWidth > holderWidth) {				
				currX = margin;
				currY = currY + childHeight + margin;				
			}						
		}
		
		//---------------------------------------------------------------
		// calculate wrapper width		
		for (i in 0...numChildren) 
		{
			wrapperWidth = Math.max(wrapperWidth, childX[i] + childWidth);
			wrapperHeight = Math.max(wrapperHeight, childY[i] + childHeight);
		}		
		holder.w = wrapperWidth + margin;
		holder.h = wrapperHeight + margin;

		// set child widths and heights
		for (i in 0...numChildren) 
		{
			var child : DisplayObject = holder.getChildAt(i);
			child.width = childWidth;
			child.height = childHeight;
		}
			
		// set child positions
		for (i in 0...numChildren) 
		{
			var child : DisplayObject = holder.getChildAt(i);
			Actuate.tween(child, tweenTime, { x:childX[i], y:childY[i]/*, width:childWidth, height:childHeight*/ } );
		}

		var holderX = Math.max(0, (holderWidth - holder.w) / 2);
		var holderY = Math.max(0, holder.y);
		holder.x = holderX;
		holder.y = holderY;
	}	
	
	
}
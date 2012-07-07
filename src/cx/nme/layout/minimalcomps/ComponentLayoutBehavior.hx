package cx.nme.layout.minimalcomps;
import com.bit101.components.Component;
import cx.nme.layout.AlignHorizontal;
import cx.nme.layout.AlignVertical;
import nme.display.Sprite;
import nme.display.Stage;
import nme.events.Event;
import nme.Lib;

/**
 * ...
 * @author Jonas Nyström
 */

class ComponentLayoutBehavior 
{
	private var target:Component;
	private var stage:Stage;
	private var alignHorizontal:AlignHorizontal;
	private var alignVertical:AlignVertical;
	private var marginLeft:Float;
	private var marginTop:Float;
	private var marginRight:Float;
	private var marginBottom:Float;
	
	public function new(target:Component, alignHorizontal:AlignHorizontal=null, alignVertical:AlignVertical=null, marginLeft=0.0, marginTop=0.0, marginRight=0.0, marginBottom=0.0) {
		this.target = target;
		this.stage = Lib.current.stage;
		this.stage.addEventListener(Event.RESIZE, onStageResize);
		this.alignHorizontal = (alignHorizontal == null) ? AlignHorizontal.Right : alignHorizontal;
		this.alignVertical = (alignVertical == null) ? AlignVertical.Bottom : alignVertical;
		this.marginLeft = marginLeft;
		this.marginTop = marginTop;
		this.marginRight = marginRight;
		this.marginBottom = marginBottom;
		onStageResize();
	}
	
	private function onStageResize(e:Event=null):Void  {

		switch (this.alignHorizontal) {
			case AlignHorizontal.Right:
				target.x = this.stage.stageWidth - this.target.width - this.marginRight;
			case AlignHorizontal.Left:
				target.x = this.marginLeft;
			case AlignHorizontal.Center:
				target.x = this.marginLeft + ((stage.stageWidth-this.marginRight) - target.width) / 2;
			case AlignHorizontal.Fill:
				target.x = this.marginLeft;
				target.width = stage.stageWidth - this.marginLeft - this.marginRight;
		}
		
		switch (this.alignVertical) {
			case AlignVertical.Bottom:
				target.y = this.stage.stageHeight - this.target.height - marginBottom;
			case AlignVertical.Top:
				target.y = marginTop;
			case AlignVertical.Center:
				target.y = this.marginTop + ((stage.stageHeight - this.marginBottom) - target.height) / 2;
			case AlignVertical.Fill:
				target.y = this.marginTop;
				target.height = stage.stageHeight - this.marginTop - this.marginBottom;
		}
	}	
}
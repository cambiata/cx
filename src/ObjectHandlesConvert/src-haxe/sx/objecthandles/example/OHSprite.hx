package sx.objecthandles.example;
import flash.display.Sprite;
import sx.objecthandles.events.ObjectChangedEvent;
import sx.objecthandles.events.PropertyChangeEvent;

/**
 * ...
 * @author Jonas Nyström
 */

class OHSprite extends Sprite
{

		public var model:OHSpriteModel;
		private var backgroundColor:Int;
		private var backgroundAlpha:Float;
		private var lineColor:Int;
		private var lineAlpha:Float;
		private var lineWidth:Float;
		
		public function new(model:OHSpriteModel, backgroundColor:Int=0xB3EAFF, backgroundAlpha:Float=1, lineColor:Int=0, lineWidth:Float=1, lineAlpha:Float=1)
		{
			super();
			this.model = model;
			model.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, onModelChange);
		
			this.backgroundColor = backgroundColor;
			this.backgroundAlpha = backgroundAlpha;
			
			this.lineColor = lineColor;
			this.lineAlpha = lineAlpha;
			this.lineWidth = lineWidth;
			x = model.x;
			y = model.y;			
			redrawSelected();
			redraw();
		}
		
		private function onModelChange( event:ObjectChangedEvent):Void
		{
			
			/*
			switch( event.property )
			{
				case "x": x = event.newValue as Number; break;
				case "y": y = event.newValue as Number; break;
				case "rotation": rotation = event.newValue as Number; break;
				case "width":  
				case "height": break;
				default: return;
			}
			*/
			trace('onModelChange');
			
			redrawSelected();
			redraw();
		}
		
		private function redrawSelected():Void
		{
			graphics.clear();
			graphics.lineStyle(this.lineWidth, this.lineColor, this.lineAlpha);
			graphics.beginFill(this.backgroundColor, this.backgroundAlpha);
			graphics.drawRoundRect(0, 0, model.width, model.height, 0, 0);
			graphics.endFill();
			
			trace('redrawSelected');
		}
		
		
		private function redraw() : Void
		{
			
		}
	
}
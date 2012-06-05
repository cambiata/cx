package example 
{
	import flash.display.Shape;
	import flash.display.Sprite;
	
	import mx.events.PropertyChangeEvent;

	
	/** 
	 * This is an example and not part of the core ObjectHandles library. 
	 **/

	public class OHSprite extends Sprite
	{
		protected var model:OHSpriteModel;
		private var backgroundColor:uint;
		private var backgroundAlpha:Number;
		private var lineColor:uint;
		private var lineAlpha:Number;
		private var lineWidth:Number;
		
		public function OHSprite(model:OHSpriteModel, backgroundColor:uint=0xB3EAFF, backgroundAlpha:Number=1, lineColor:uint=0, lineWidth:Number=1, lineAlpha:Number=1)
		{
			super();
			this.model = model;
			model.addEventListener( PropertyChangeEvent.PROPERTY_CHANGE, onModelChange );
		
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
		
		protected function onModelChange( event:PropertyChangeEvent):void
		{
			
			switch( event.property )
			{
				case "x": x = event.newValue as Number; break;
				case "y": y = event.newValue as Number; break;
				case "rotation": rotation = event.newValue as Number; break;
				case "width":  
				case "height": break;
				default: return;
			}
			
			redrawSelected();
			redraw();
		}
		
		private function redrawSelected():void
		{
			graphics.clear();
			graphics.lineStyle(this.lineWidth, this.lineColor, this.lineAlpha);
			graphics.beginFill(this.backgroundColor, this.backgroundAlpha);
			graphics.drawRoundRect(0, 0, model.width, model.height, 0, 0);
			graphics.endFill();
		}
		
		
		protected function redraw() : void
		{
			
		}
	
	}
}
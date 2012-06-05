package
{
	import com.roguedevelopment.objecthandles.As3ChildManager;
	import com.roguedevelopment.objecthandles.HandleDefinitions;
	import com.roguedevelopment.objecthandles.HandleDescription;
	import com.roguedevelopment.objecthandles.HandleRoles;
	import com.roguedevelopment.objecthandles.ObjectChangedEvent;
	import com.roguedevelopment.objecthandles.ObjectHandles;
	import com.roguedevelopment.objecthandles.constraints.MovementConstraint;
	import com.roguedevelopment.objecthandles.constraints.SizeConstraint;
	
	import example.OHSprite;
	import example.OHSpriteModel;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import mx.utils.ObjectUtil;
	
	[SWF(widthPercent="100%", heightPercent="100%", frameRate="30")]
	public class Main extends Sprite
	{
		private var objectHandles:ObjectHandles;
		public function Main()
		{
			this.stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			this.init();
			//this.init2();
		}
		
		public function init2(): void {
			
			new ObjectHandles(this, null, null, null);
		}
		
		protected function init() : void
		{
			objectHandles = new ObjectHandles(this, null, null, new As3ChildManager());
			objectHandles.enableMultiSelect = true;			
			objectHandles.defaultHandles = HandleDefinitions.RESIZE_MOVE_NOROTATE;
			
			var model:OHSpriteModel;
			var ohSprite:OHSprite;
			
			model = new OHSpriteModel(200, 10, 100, 40);
			ohSprite = new OHSprite(model, 0xFF0000, 0.5);
			objectHandles.registerComponent(model, ohSprite);
			this.addChild(ohSprite);
			//ohSprite.addEventListener(MouseEvent.MOUSE_DOWN, onSpriteMouseDown);
			
			
			/*
			model = new OHSpriteModel(100, 50, 20, 200);
			ohSprite = new OHSprite(model, 0x0000FF, 0.5);
			objectHandles.registerComponent(model, ohSprite);
			this.addChild(ohSprite);
			
			model = new OHSpriteModel();
			ohSprite = new OHSprite(model, 0x00FF00, 0.5);
			objectHandles.registerComponent(model, ohSprite);
			this.addChild(ohSprite);
			
			objectHandles.addEventListener(ObjectChangedEvent.OBJECT_RESIZED, onObjectResized);
			objectHandles.addEventListener(ObjectChangedEvent.OBJECT_MOVED, onObjectMoved);
			*/
		}		
		
		protected function onObjectMoved(event:Event):void
		{
			trace('onObjectMoved', ObjectHandles(event.currentTarget).selectionManager.currentlySelected[0]);
		}
		
		protected function onObjectResized(event:ObjectChangedEvent):void
		{
			trace('onObjectResized', ObjectHandles(event.currentTarget).selectionManager.currentlySelected[0]);
		}
		
		protected function onSpriteMouseDown(event:MouseEvent):void
		{
			trace('onSpriteMouseDown');
		}
		
	}
}
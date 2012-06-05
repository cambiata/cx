package ;

import flash.display.Sprite;
import flash.Lib;
import sx.objecthandles.As3ChildManager;
import sx.objecthandles.example.OHSprite;
import sx.objecthandles.example.OHSpriteModel;
import sx.objecthandles.HandleDefinitions;
import sx.objecthandles.ObjectHandles;

/**
 * ...
 * @author Jonas Nyström
 */

class Main extends Sprite
{
	
	static function main() 
	{
		Lib.current.addChild(new Main());
	}
	
	public function new() {
		super();
		
		var objectHandles = new ObjectHandles(this, null, null, new As3ChildManager());
		objectHandles.enableMultiSelect = true;			
		objectHandles.defaultHandles = HandleDefinitions.RESIZE_MOVE_NOROTATE;		
		
		var model:OHSpriteModel;
		var ohSprite:OHSprite;
		
		model = new OHSpriteModel(200, 10, 100, 40);
		ohSprite = new OHSprite(model, 0xFF0000, 0.5);
		objectHandles.registerComponent(model, ohSprite);
		this.addChild(ohSprite);
		/*
		model = new OHSpriteModel(100, 50, 20, 200);
		ohSprite = new OHSprite(model, 0x0000FF, 0.5);
		objectHandles.registerComponent(model, ohSprite);
		this.addChild(ohSprite);
		
		model = new OHSpriteModel();
		ohSprite = new OHSprite(model, 0x00FF00, 0.5);
		objectHandles.registerComponent(model, ohSprite);
		this.addChild(ohSprite);
		*/
		
	}
	
}
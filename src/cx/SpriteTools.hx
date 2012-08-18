package cx;
import nme.events.Event;
import nme.display.Sprite;
import nme.events.MouseEvent;

/**
 * ...
 * @author Jonas Nyström
 */

class SpriteTools 
{

	static public function getSpriteRect(x = 0.0, y = 0.0, width = 50.0, height = 50.0, color = 0x0000FF) {
		var s = new Sprite();
		s.graphics.beginFill(color);
		s.graphics.drawRect(x, y, width, height);
		s.x = x;
		s.y = y;
		s.width = width;
		s.height = height;		
		return s;
	}
	
	static public function getTestRect(sprite:Sprite) {	
		sprite.graphics.beginFill(0x0000FF);
		sprite.graphics.drawRect(0, 0, 100, 100);		
	}
	
	static public function getButtonSprite(x = 0.0, y = 0.0, w = 20.0, h = 20.0, color = 0x0000FF, onMouseDown:Event->Void=null) {
		if (w == 0) w = 20;
		if (h == 0) h = 20;
		if (color == 0) color = 0x0000FF;
		
		var s = getSpriteRect(0, 0, w, h);
		s.x = x;
		s.y = y;
		
		s.addEventListener(MouseEvent.ROLL_OVER, function(e:Event) {			
			s.graphics.clear();
			s.graphics.beginFill(0x00FF00);
			s.graphics.drawRect(0, 0, w, h);			
		}); 
		
		s.addEventListener(MouseEvent.ROLL_OUT, function(e:Event) {
			s.graphics.clear();
			s.graphics.beginFill(color);
			s.graphics.drawRect(0, 0, w, h);			
		});
		
		if (onMouseDown != null) {
			s.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		}
		
		return s;
	}
	
	static public function clearAll(sprite:Sprite) {
		sprite.graphics.clear();
		while (sprite.numChildren > 0) sprite.removeChildAt(0);		
	}
	
	
	
}
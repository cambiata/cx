package cx;
import nme.display.Sprite;

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

	
}
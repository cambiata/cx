package cx.nme.display.behavior;
import nme.display.Sprite;

/**
 * ...
 * @author Jonas Nyström
 */

class AbstractSpriteBehavior {
	private var _target:Sprite;
	public function new(target:Sprite) {
		this._target = target;
	}
}
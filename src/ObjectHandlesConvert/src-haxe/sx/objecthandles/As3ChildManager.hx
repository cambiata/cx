package sx.objecthandles;
import flash.display.Sprite;

/**
 * ...
 * @author Jonas Nyström
 */

	class As3ChildManager implements IChildManager
	{
		public function new() { }
		
		public function addChild(container:Sprite, child:Sprite):Void
		{
			container.addChild( cast(child, Sprite));
		}
		
		public function removeChild(container:Sprite, child:Sprite):Void
		{

			container.removeChild( cast(child, Sprite));
		}
	}
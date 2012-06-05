package sx.objecthandles;
import flash.display.DisplayObject;
import flash.display.Sprite;

/**
 * ...
 * @author Jonas Nyström
 */


	interface IChildManager
	{
		function addChild( container:Sprite, child:Sprite ):Void;
		function removeChild( container:Sprite, child:Sprite ):Void;
	}

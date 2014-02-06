package nx3.render;

#if (nme)
import nme.display.Sprite;
#else
import flash.display.Sprite;
#end

import nx3.render.scaling.TScaling;

/**
 * ...
 * @author 
 */
interface ISpriteRenderer
{

	function initTargetSprite(target:Sprite, scaling:TScaling): Void;
	
}
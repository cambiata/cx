package nx3.render;


import flash.display.Sprite;


import nx3.render.scaling.TScaling;

/**
 * ...
 * @author 
 */
interface ISpriteRenderer
{

	function initTargetSprite(target:Sprite, scaling:TScaling): Void;
	
}
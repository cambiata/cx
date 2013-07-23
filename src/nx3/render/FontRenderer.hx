package nx3.render;
import flash.display.Sprite;
import nx3.display.DComplex;
import nx3.display.DNote;
import nx3.render.scaling.TScaling;

/**
 * ...
 * @author 
 */
class FontRenderer implements IRenderer
{

	var scaling:TScaling;
	var target:Sprite;	
	
	function initTargetSprite(target:Sprite, scaling:TScaling): Void
	{
		this.target = target;
		this.scaling = scaling;
	}	
	
	public function new(target:Sprite,  scaling:TScaling) 
	{
		this.initTargetSprite(target, scaling);
	}
	
	/* INTERFACE nx3.render.IRenderer */
	
	public function notelines(x:Float, y:Float, width:Float):Void 
	{
		
	}
	
	public function stave(x:Float, y:Float, dnote:DNote):Void 
	{
		
	}
	
	public function heads(x:Float, y:Float, dnote:DNote):Void 
	{
		
	}
	
	public function note(x:Float, y:Float, dnote:DNote):Void 
	{
		
	}
	
	public function complex(x:Float, y:Float, dcomplex:DComplex):Void 
	{
		
	}
	
}
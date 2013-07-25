package nx3.render;


import flash.display.Sprite;


import nx3.elements.DComplex;
import nx3.elements.DNote;
import nx3.render.IRenderer;
import nx3.render.scaling.Scaling;
import nx3.render.scaling.TScaling;

/**
 * ...
 * @author 
 */
class MultiRenderer implements IRenderer
{
	var target:Sprite;
	var scaling:TScaling;
	var renderers:Array<IRenderer>;

	public function new(target:Sprite,  scaling:TScaling, renderers:Array<Class<IRenderer>>) 
	{
		this.target = target;
		this.scaling = scaling;
		this.renderers = [];
		for (r in renderers)
		{
			var renderer:IRenderer = Type.createInstance(r, [target, scaling]);		
			this.renderers.push(renderer);
		}
		
		//this.renderers = renderers;
	}
	
	/* INTERFACE nx3.render.IRenderer */
	
	public function notelines(x:Float, y:Float, width:Float):Void 
	{
		for (r in this.renderers) r.notelines(x, y, width);
	}
	
	public function stave(x:Float, y:Float, dnote:DNote):Void 
	{
		for (r in this.renderers) r.stave(x, y, dnote);
	}
	
	public function heads(x:Float, y:Float, dnote:DNote):Void 
	{		
		for (r in this.renderers) r.heads(x, y, dnote);  
	}
	
	public function note(x:Float, y:Float, dnote:DNote):Void 
	{
		for (r in this.renderers) r.note(x, y, dnote);
	}
	
	public function complex(x:Float, y:Float, dcomplex:DComplex):Void
	{
		for (r in this.renderers) r.complex(x, y, dcomplex);
		
	}
	
	/* INTERFACE nx3.render.IRenderer */
	
	public function signs(x:Float, y:Float, dcomplex:DComplex):Void 
	{
		for (r in this.renderers) r.signs(x, y, dcomplex);
	}
	
}